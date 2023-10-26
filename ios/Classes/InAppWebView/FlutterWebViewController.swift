//
//  FlutterWebViewController.swift
//  flutter_inappwebview
//
//  Created by Lorenzo on 13/11/18.
//

import Foundation
import WebKit

public class FlutterWebViewController: NSObject, FlutterPlatformView, Disposable {
    
    var myView: UIView?

    init(registrar: FlutterPluginRegistrar, withFrame frame: CGRect, viewIdentifier viewId: Any, params: NSDictionary) {
        super.init()
        
        myView = UIView(frame: frame)
        myView!.clipsToBounds = true
        
        let initialSettings = params["initialSettings"] as! [String: Any?]
        let contextMenu = params["contextMenu"] as? [String: Any]
        let windowId = params["windowId"] as? Int64
        let initialUserScripts = params["initialUserScripts"] as? [[String: Any]]
        let pullToRefreshInitialSettings = params["pullToRefreshSettings"] as! [String: Any?]
        let keyboardAppearanceDark = params["keyboardAppearanceDark"] as? Bool ?? false
        
        var userScripts: [UserScript] = []
        if let initialUserScripts = initialUserScripts {
            for intialUserScript in initialUserScripts {
                userScripts.append(UserScript.fromMap(map: intialUserScript, windowId: windowId)!)
            }
        }
        
        let settings = InAppWebViewSettings()
        let _ = settings.parse(settings: initialSettings)
        let preWebviewConfiguration = InAppWebView.preWKWebViewConfiguration(settings: settings)
        
        var webView: InAppWebView?
        
        if let wId = windowId, let webViewTransport = InAppWebView.windowWebViews[wId] {
            webView = webViewTransport.webView
            webView!.id = viewId
            let channel = FlutterMethodChannel(name: InAppWebView.METHOD_CHANNEL_NAME_PREFIX + String(describing: viewId),
                                               binaryMessenger: registrar.messenger())
            webView!.channelDelegate = WebViewChannelDelegate(webView: webView!, channel: channel)
            webView!.frame = myView!.bounds
            webView!.contextMenu = contextMenu
            webView!.initialUserScripts = userScripts
        } else {
            webView = InAppWebView(id: viewId,
                                   registrar: registrar,
                                   frame: myView!.bounds,
                                   configuration: preWebviewConfiguration,
                                   contextMenu: contextMenu,
                                   userScripts: userScripts)
        }
        
        if (keyboardAppearanceDark) {
            setKeyboardAppearanceDark()
        }
        
        let pullToRefreshSettings = PullToRefreshSettings()
        let _ = pullToRefreshSettings.parse(settings: pullToRefreshInitialSettings)
        let pullToRefreshControl = PullToRefreshControl(registrar: registrar, id: viewId, settings: pullToRefreshSettings)
        webView!.pullToRefreshControl = pullToRefreshControl
        pullToRefreshControl.delegate = webView!
        pullToRefreshControl.prepare()
        
        let findInteractionController = FindInteractionController(
            registrar: SwiftFlutterPlugin.instance!.registrar!,
            id: viewId, webView: webView!, settings: nil)
        webView!.findInteractionController = findInteractionController
        findInteractionController.prepare()

        webView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myView!.autoresizesSubviews = true
        myView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myView!.addSubview(webView!)

        webView!.settings = settings
        webView!.prepare()
        webView!.windowCreated = true
    }
    
    public func webView() -> InAppWebView? {
        for subview in myView?.subviews ?? []
        {
            if let item = subview as? InAppWebView
            {
                return item
            }
        }
        return nil
    }
    
    public func view() -> UIView {
        return myView!
    }
    
    public func makeInitialLoad(params: NSDictionary) {
        guard let webView = webView() else {
            return
        }
        
        let windowId = params["windowId"] as? Int64
        let initialUrlRequest = params["initialUrlRequest"] as? [String: Any?]
        let initialFile = params["initialFile"] as? String
        let initialData = params["initialData"] as? [String: String?]
        
        if windowId == nil {
            if #available(iOS 11.0, *) {
                webView.configuration.userContentController.removeAllContentRuleLists()
                if let contentBlockers = webView.settings?.contentBlockers, contentBlockers.count > 0 {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: contentBlockers, options: [])
                        let blockRules = String(data: jsonData, encoding: String.Encoding.utf8)
                        WKContentRuleListStore.default().compileContentRuleList(
                            forIdentifier: "ContentBlockingRules",
                            encodedContentRuleList: blockRules) { (contentRuleList, error) in

                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }

                                let configuration = webView.configuration
                                configuration.userContentController.add(contentRuleList!)

                                self.load(initialUrlRequest: initialUrlRequest, initialFile: initialFile, initialData: initialData)
                        }
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            load(initialUrlRequest: initialUrlRequest, initialFile: initialFile, initialData: initialData)
        }
        else if let wId = windowId, let webViewTransport = InAppWebView.windowWebViews[wId] {
            webView.load(webViewTransport.request)
        }
    }
    
    func load(initialUrlRequest: [String:Any?]?, initialFile: String?, initialData: [String: String?]?) {
        guard let webView = webView() else {
            return
        }
        
        if let initialFile = initialFile {
            do {
                try webView.loadFile(assetFilePath: initialFile)
            }
            catch let error as NSError {
                dump(error)
            }
        }
        else if let initialData = initialData, let data = initialData["data"]!,
                let mimeType = initialData["mimeType"]!, let encoding = initialData["encoding"]!,
                let baseUrl = URL(string: initialData["baseUrl"]! ?? "about:blank") {
            var allowingReadAccessToURL: URL? = nil
            if let allowingReadAccessTo = webView.settings?.allowingReadAccessTo, baseUrl.scheme == "file" {
                allowingReadAccessToURL = URL(string: allowingReadAccessTo)
                if allowingReadAccessToURL?.scheme != "file" {
                    allowingReadAccessToURL = nil
                }
            }
            webView.loadData(data: data,
                             mimeType: mimeType,
                             encoding: encoding,
                             baseUrl: baseUrl,
                             allowingReadAccessTo: allowingReadAccessToURL)
        }
        else if let initialUrlRequest = initialUrlRequest {
            let urlRequest = URLRequest.init(fromPluginMap: initialUrlRequest)
            var allowingReadAccessToURL: URL? = nil
            if let allowingReadAccessTo = webView.settings?.allowingReadAccessTo, let url = urlRequest.url, url.scheme == "file" {
                allowingReadAccessToURL = URL(string: allowingReadAccessTo)
                if allowingReadAccessToURL?.scheme != "file" {
                    allowingReadAccessToURL = nil
                }
            }
            webView.loadUrl(urlRequest: urlRequest, allowingReadAccessTo: allowingReadAccessToURL)
        }
    }
    
    public func dispose() {
        if let webView = webView() {
            webView.dispose()
        }
        myView = nil
    }
    
    deinit {
        debugPrint("FlutterWebViewController - dealloc")
        dispose()
    }
    
    private func setKeyboardAppearanceDark() {
        let handler: @convention(block) (AnyObject) -> UIKeyboardAppearance = { (s:AnyObject) in
            return UIKeyboardAppearance.dark
        }
        let darkImp:IMP = imp_implementationWithBlock(handler)
        for classString:String? in ["WKContentView", "UITextInputTraits"] {
            let cls:AnyClass? = NSClassFromString(classString!)
            let method:Method? = class_getInstanceMethod(cls, Selector(("keyboardAppearance")))
            if method != nil {
                method_setImplementation(method!, darkImp)
            } else {
                class_addMethod(cls, Selector(("keyboardAppearance")), darkImp, "l@:")
            }
        }
    }
}
