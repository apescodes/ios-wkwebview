//
//  RewardedVideoAD.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/22/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import Appodeal

final class RewardedVideoAD: NSObject, ADStrategy {
  
  var webBridge: WebViewBridge?
  
  init(webBridge: WebViewBridge) {
    self.webBridge = webBridge
  }
  
  func showAd() {
    let placement = ""
    
    guard
      Appodeal.isInitalized(for: .rewardedVideo),
      Appodeal.canShow(.rewardedVideo, forPlacement: placement)
      else {
        return
    }
    
    if let topVC = UIApplication.getTopViewController() {
      Appodeal.showAd(.rewardedVideo, forPlacement: placement, rootViewController: topVC)
    }
  }
  
  func updateState() {
    rewardedVideoDidLoadAdIsPrecache(true)
  }
}

extension RewardedVideoAD: AppodealRewardedVideoDelegate {
  
  func rewardedVideoDidLoadAdIsPrecache(_ precache: Bool) {
    webBridge?.emitEvent(message: "onRewardedVideoLoaded", precache.description)
  }
  
  func rewardedVideoDidFailToLoadAd() {
    webBridge?.emitEvent(message: "onRewardedVideoFailedToLoad")
  }
  
  func rewardedVideoDidFailToPresentWithError(_ error: Error) {
    webBridge?.emitEvent(message: "onRewardedVideoShowFailed")
  }
  
  func rewardedVideoDidPresent() {
    webBridge?.emitEvent(message: "onRewardedVideoShown")
  }
  
  func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {
    webBridge?.emitEvent(message: "onRewardedVideoClosed")
  }
  
  func rewardedVideoDidFinish(_ rewardAmount: float_t, name rewardName: String?) {
    webBridge?.emitEvent(message: "onRewardedVideoFinished")
  }
  
  func rewardedVideoDidClick() {
    webBridge?.emitEvent(message: "onRewardedVideoClicked")
  }
  
  func rewardedVideoDidExpired() {
    webBridge?.emitEvent(message: "onRewardedVideoExpired")
  }
}

