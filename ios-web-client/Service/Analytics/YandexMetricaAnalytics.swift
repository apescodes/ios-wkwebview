//
//  YandexMetricaAnalytics.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/24/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import YandexMobileMetrica

final class YandexMetricaAnalytics: Analytics {
  
  func initMetrica(_ apiKey: String = "73b27732-f023-42c4-bdec-6001acf31224") {
    let configuration = YMMYandexMetricaConfiguration(apiKey: apiKey)
    YMMYandexMetrica.activate(with: configuration!)
  }
  
  func reportEvent(eventName: String, eventParams: [AnyHashable : Any]?) {
    YMMYandexMetrica.reportEvent(eventName, parameters: eventParams) { error in
      print("ERROR in Metrika -- \(error.localizedDescription)")
    }
  }
}
