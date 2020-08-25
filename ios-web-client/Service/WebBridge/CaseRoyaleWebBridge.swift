//
//  CaseRoyaleWebBridge.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/24/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import WebKit

enum ScriptMessage: String {
  
  case showAds
  case showInterstitialAds
  case getStoreProducts
  case purchaseStoreProduct
  case reportEvent
  case initAdsAggregator
}

final class CaseRoyaleWebBridge: WebViewBridge {
  
  private let webEntryPoint = "platform"//"webEntryPoint"
  private let messages:[ScriptMessage] = [
    .showAds,
    .showInterstitialAds,
    .getStoreProducts,
    .purchaseStoreProduct,
    .reportEvent,
    .initAdsAggregator
  ]
  
  private let webView: WKWebView
  
  init(webView: WKWebView) {
    self.webView = webView
    
    super.init(adService: ADService(), billing: Purchase(), analytics: YandexMetricaAnalytics())
    adService.update(strategy: RewardedVideoAD(webBridge: self))
    
    messages.forEach {
      registerFor(message: $0.rawValue)
    }
  }
  
  func registerFor(message name: String) {
    webView.configuration.userContentController.add(self, name: name)
  }
  
  override func emitEvent(message: String, _ parameter: String = "") {
    let method = "window." + webEntryPoint + "emitEvent('" + message + "','" + parameter + "')"
    call(methodName: method)
  }
  
  
  func call(methodName: String) {
    let event = methodName // "javascript:" + webEntryPoint + "." + methodName
    webView.evaluateJavaScript(event) { [weak self] result, error in
      self?.handleEmit(result: result, error: error)
    }
  }
  
  private func handleEmit(result: Any?, error: Error?) {
    guard let error = error else {
      return
    }
    
    print(error.localizedDescription)
  }
  
  private func handle(message: WKScriptMessage) {
    switch message.name {
    case ScriptMessage.initAdsAggregator.rawValue:
      guard let hasConsent = message.body as? Bool else {
        return
      }
      
      SetupService().initAdsAggregator(hasConsent: hasConsent)
    case ScriptMessage.showInterstitialAds.rawValue:
      adService.update(strategy: InterstialAD(webBridge: self))
      adService.showAd()
    case ScriptMessage.showAds.rawValue:
      adService.update(strategy: RewardedVideoAD(webBridge: self))
      adService.showAd()
    case ScriptMessage.getStoreProducts.rawValue:
      guard let productIds = message.body as? String else {
        return
      }
      
      let products = productIds.replacingOccurrences(of: "[\\[\\]\"]", with: "", options: .regularExpression, range: nil).components(separatedBy: ",")
      billing.getProducts(productIds: products)
    case ScriptMessage.reportEvent.rawValue:
      guard let params = message.body as? [String: Any] else {
        return
      }
      
      analytics.reportEvent(eventName: "", eventParams: params)
    default:
      return
    }
  }
}

extension CaseRoyaleWebBridge: WKScriptMessageHandler {
  
  func userContentController(
    _ userContentController:
    WKUserContentController,
    didReceive message: WKScriptMessage) {
    handle(message: message)
  }
}
