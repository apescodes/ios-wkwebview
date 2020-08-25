//
//  API.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/20/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import UIKit

enum API {
  
//  #if DEBUGMODE
//    static let gameUrl: String = "http://192.168.0.104/game?\(paramenters)"
//  #else
    static let gameUrl: String = "https://caseroyale.com/game?\(paramenters)"
//  #endif
  
  static let paramenters = [versionCode, deviceId, locale, countryCode].joined(separator: "?")
  
  private static let deviceId = "ios_id=" + (UIDevice.current.identifierForVendor?.uuidString ?? "")
  private static let versionCode = "version_code=60"
  private static let locale = "language_key=" + Locale.current.identifier
  private static let countryCode = "country_code=" + (Locale.current.regionCode ?? "")
}
