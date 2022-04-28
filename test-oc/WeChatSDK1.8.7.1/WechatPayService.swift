//
//  WechatPayService.swift
//  OrderPlaceSdk_Example
//
//  Created by 陈培爵 on 2018/11/19.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import OrderPlaceSdkPrd
public protocol WeChatPayDelegate: AnyObject {
    func wechatPayOrder(body: NSDictionary, callback: CallbackHandler?)
    func wechatGetVersion(callback: CallbackHandler?)
    func isInstalled(callback: CallbackHandler?)
    func wechatApplicationOpenUrl(_ app: UIApplication, url: URL)
    func wechatApplication(_ app: UIApplication, continue userActivity: NSUserActivity)
}

@objc public class WechatPayService: OrderPlaceService {
    static public var SERVICE_NAME: String = "WeChatPayService"

    var payResultCallback: CallbackHandler? = nil
    // We don't need weak here, because we are the delegate of run time get.
    private static var weChatPayDelegate: WeChatPayDelegate? = WechatExecutor.shared

    var options: [String: Any]?
    @objc public init(_ options: [String: Any]) {
        self.options = options;
        WechatPayService.weChatPayDelegate = WechatExecutor.shared
    }

    public override func getServiceName() -> String {
        
        if let features = self.options?["features"] as? String {
            let fs = features.split(separator: ",");
            if (fs.contains("wechatpayhk")) {
                WechatPayService.SERVICE_NAME = "WeChatPayHKService";
            }
        }
        
        return WechatPayService.SERVICE_NAME
    }

    public override func handleMessage(method: String, body: NSDictionary, callback: CallbackHandler?) {
        switch method {
        case "requestPay":
            payResultCallback = callback
            payOrder(body: body, callback: callback)
            break;
        case "getWeChatSdkVersion":
            getVersion(callback: callback)
            break;
        case "registerApp":
            registerApp(body: body, callback: callback)
            break;
        case "isWXAppInstalled":
            isWXAppInstalled(callback)
            break;
        default:
            break;
        }
    }
    
    private func isWXAppInstalled(_ callback: CallbackHandler?) {
        if let del = WechatPayService.weChatPayDelegate {
            del.isInstalled(callback: callback)
        }
    }
    private func registerApp(body: NSDictionary, callback: CallbackHandler?) {
        debugPrint("registerApp body:\(body)")
    }

    private func getVersion(callback: CallbackHandler?) {

        if let del = WechatPayService.weChatPayDelegate {
            del.wechatGetVersion(callback: callback)
        }

    }

    private func payOrder(body: NSDictionary, callback: CallbackHandler?) {
        if let del = WechatPayService.weChatPayDelegate {
            del.wechatPayOrder(body: body, callback: callback)
        }
    }

    private func showAlert(message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.vc.present(alertController, animated: true, completion: nil)
    }
    
    @objc public static func applicationOpenUrl(_ app: UIApplication, url: URL) {
        if let del = WechatPayService.weChatPayDelegate {
            del.wechatApplicationOpenUrl(app, url: url)
        }
    }
    @objc public static func wechatApplication(_ app: UIApplication, continue userActivity: NSUserActivity) {
        if let del = WechatPayService.weChatPayDelegate {
            del.wechatApplication(app, continue: userActivity)
        }
    }
    
    @objc public static func application(_ application: UIApplication, universalLink: String, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let dictArray = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [Dictionary<String, Any>] {
            for dicts in dictArray {
                if let dict = dicts["CFBundleURLName"] as? String, dict == "weixin", let arrayCFBundleURLSchemes = dicts["CFBundleURLSchemes"] as? [String], let weixinURLSchemes = arrayCFBundleURLSchemes.first {
                    WXApi.registerApp(weixinURLSchemes, universalLink: universalLink)
                    break;
                }
                
            }
        }
    }
}
