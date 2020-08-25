//
//  Analytics.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/24/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation

protocol Analytics {
  
  func reportEvent(eventName: String, eventParams: [AnyHashable : Any]?)
}
