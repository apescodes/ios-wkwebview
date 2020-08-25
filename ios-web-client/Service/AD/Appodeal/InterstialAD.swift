//
//  InterstialAD.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/21/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import Appodeal

final class InterstialAD: NSObject, ADStrategy {
  
  var webBridge: WebViewBridge?
  
  init(webBridge: WebViewBridge) {
    self.webBridge = webBridge
  }
  
  func showAd() {
    let placement = ""
    
    guard
      Appodeal.isInitalized(for: .interstitial),
      Appodeal.canShow(.interstitial, forPlacement: placement)
      else {
        return
    }
    
    if let topVC = UIApplication.getTopViewController() {
      Appodeal.showAd(.interstitial, forPlacement: placement, rootViewController: topVC)
    }
  }
  
  func updateState() {
    interstitialDidLoadAdIsPrecache(true)
  }
}

extension InterstialAD: AppodealInterstitialDelegate {
  
  func interstitialDidLoadAdIsPrecache(_ precache: Bool) {
    webBridge?.emitEvent(message: "onInterstitialLoaded", precache.description)
  }
  
  func interstitialDidFailToLoadAd() {
    webBridge?.emitEvent(message: "onInterstitialFailedToLoad")
  }
  
  func interstitialDidFailToPresent() {
    webBridge?.emitEvent(message: "onInterstitialShowFailed")
  }
  
  func interstitialWillPresent() {
    webBridge?.emitEvent(message: "onInterstitialShown")
  }
  
  func interstitialDidDismiss() {
    webBridge?.emitEvent(message: "onInterstitialClosed")
  }
  
  func interstitialDidClick() {
    webBridge?.emitEvent(message: "onInterstitialClicked")
  }
  
  func interstitialDidExpired() {
    webBridge?.emitEvent(message: "onInterstitialExpired")
  }
}
