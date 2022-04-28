//
//  WechatExecutor.swift
//  OrderPlaceSdk_Example
//
//  Created by 陈培爵 on 2018/11/22.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import OrderPlaceSdkPrd
private let sharedExecutor = WechatExecutor()
@objc public class WechatExecutor: NSObject {

    static var shared: WechatExecutor {
        return sharedExecutor
    }
    
    public required override init() {
        super.init()
    }

    private var payResultCallback: CallbackHandler? = nil

    private func showAlert(message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
extension WechatExecutor: WeChatPayDelegate {

    public func wechatPayOrder(body: NSDictionary, callback: CallbackHandler?) {
        if !WXApi.isWXAppInstalled() {
            self.showAlert(message: "Please install WeChat first.")
            return
        }
        payResultCallback = callback

        if let partnerId = body.value(forKey: "partnerId") as? String, let prepayId = body.value(forKey: "prepayId") as? String, let nonceStr = body.value(forKey: "nonceStr") as? String, let timeStamp = body.value(forKey: "timeStamp") as? UInt32, let package = body.value(forKey: "packageValue") as? String, let sign = body.value(forKey: "sign") as? String {
            let req = PayReq()
            req.partnerId = partnerId
            req.prepayId = prepayId
            req.nonceStr = nonceStr
            req.timeStamp = timeStamp
            req.package = package
            req.sign = sign
            WXApi.send(req)
        } else {
            debugPrint("params format error")
        }
    }

    public func wechatGetVersion(callback: CallbackHandler?) {
        let version = WXApi.getVersion()
        let dict = ["wechatSdkVersion": version]
        debugPrint("wechatSdkVersion:\(version)")
        callback?.success(response: dict)
    }
    
    public func isInstalled(callback: CallbackHandler?) {
        let install = WXApi.isWXAppInstalled()
        let dict = ["isWXAppInstalled": install];
        callback?.success(response: dict)
    }

    
    public func wechatApplicationOpenUrl(_ app: UIApplication, url: URL) {
        let wxapiManager = WXApiManager.sharedManager
        wxapiManager.payResultCallback = payResultCallback
        WXApi.handleOpen(url, delegate: wxapiManager)

    }

    
    public func wechatApplication(_ app: UIApplication, continue userActivity: NSUserActivity) {
        let wxapiManager = WXApiManager.sharedManager
        wxapiManager.payResultCallback = payResultCallback
        WXApi.handleOpenUniversalLink(userActivity, delegate: wxapiManager)
    }

}

