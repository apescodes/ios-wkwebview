//
//  WebViewBridge.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/21/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import WebKit

class WebViewBridge: NSObject {
  
  let adService: ADServiceFacade
  let billing: BillingService
  let analytics: Analytics
  
  init(adService: ADServiceFacade, billing: BillingService, analytics: Analytics) {
    self.adService = adService
    self.billing = billing
    self.analytics = analytics
  }
  
  func emitEvent(message: String, _ parameter: String = "") {
    // should be overrided
  }
}
