//
//  ADService.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/21/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import UIKit

protocol ADStrategy {
  
  func showAd()
  func updateState()
}

protocol ADServiceFacade {
  
  func showAd()
  func updateState()
  func update(strategy: ADStrategy)
}

class ADService: ADServiceFacade {
  
  private var adStrategy: ADStrategy?
  
  var webBridge: WebViewBridge?
  
  func update(strategy: ADStrategy) {
    adStrategy = strategy
  }
  
  func showAd() {
    adStrategy?.showAd()
  }
  
  func updateState() {
    adStrategy?.updateState()
  }
}
