//
//  SetupService.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/20/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import Appodeal

final class SetupService {
  
  private var rechabilityObserver = ReachabilityHandler()
  
  var isConnected: Bool {
    rechabilityObserver.hasConnection
  }
  
  func setupNetworkHandler() {
    rechabilityObserver.startMonitoring()
  }
  
  func removeNetworkHandler() {
    rechabilityObserver.stopMonitoring()
  }
  
  //MARK: - AD
  
  func setupAd() {
    Appodeal.initialize(
      withApiKey: "dd3215441fc49a6d92c1b250ea7973430ff68ac13bb1bc70",
      types: [AppodealAdType.interstitial, AppodealAdType.rewardedVideo],
      hasConsent: true
    )
  }
  
  func initAdsAggregator(hasConsent: Bool) {
    Appodeal.updateConsent(hasConsent)
  }
}
