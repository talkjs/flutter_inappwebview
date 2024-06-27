//
//  WebMessageChannel.swift
//  flutter_inappwebview
//
//  Created by Lorenzo Pichilli on 10/03/21.
//

import Foundation
import FlutterMacOS

public class WebMessageChannel : FlutterMethodCallDelegate {
    static var METHOD_CHANNEL_NAME_PREFIX = "com.talkjs/talkjs_flutter_inappwebview_web_message_channel_"
    var id: String
    var channelDelegate: WebMessageChannelChannelDelegate?
    weak var webView: InAppWebView?
    var ports: [WebMessagePort] = []
    
    public init(id: String) {
        self.id = id
        super.init()
        let channel = FlutterMethodChannel(name: WebMessageChannel.METHOD_CHANNEL_NAME_PREFIX + id,
                                       binaryMessenger: SwiftFlutterPlugin.instance!.registrar!.messenger)
        self.channelDelegate = WebMessageChannelChannelDelegate(webMessageChannel: self, channel: channel)
        self.ports = [
            WebMessagePort(name: "port1", webMessageChannel: self),
            WebMessagePort(name: "port2", webMessageChannel: self)
        ]
    }
    
    public func initJsInstance(webView: InAppWebView, completionHandler: ((WebMessageChannel) -> Void)? = nil) {
        self.webView = webView
        if let webView = self.webView {
            webView.evaluateJavascript(source: """
            (function() {
                \(WEB_MESSAGE_CHANNELS_VARIABLE_NAME)["\(id)"] = new MessageChannel();
            })();
            """) { (_) in
                completionHandler?(self)
            }
        } else {
            completionHandler?(self)
        }
    }
    
    public func toMap() -> [String:Any?] {
        return [
            "id": id
        ]
    }
    
    public func dispose() {
        channelDelegate?.dispose()
        channelDelegate = nil
        for port in ports {
            port.dispose()
        }
        ports.removeAll()
        webView?.evaluateJavascript(source: """
        (function() {
            var webMessageChannel = \(WEB_MESSAGE_CHANNELS_VARIABLE_NAME)["\(id)"];
            if (webMessageChannel != null) {
                webMessageChannel.port1.close();
                webMessageChannel.port2.close();
                delete \(WEB_MESSAGE_CHANNELS_VARIABLE_NAME)["\(id)"];
            }
        })();
        """)
        webView = nil
    }
    
    deinit {
        debugPrint("WebMessageChannel - dealloc")
        dispose()
    }
}
