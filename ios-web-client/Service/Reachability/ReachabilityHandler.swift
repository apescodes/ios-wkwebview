//
//  ReachabilityHandler.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/20/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import UIKit

final class ReachabilityHandler {
  
  private var reachability: Reachability? = Reachability()
  
  // MARK: - LifeCycle
  
  deinit {
    stopMonitoring()
  }
  
  // MARK: - Public
  
  var hasConnection: Bool {
    reachability?.connection != Reachability.Connection.none
  }
  
  func startMonitoring() {
    stopMonitoring()
    try? reachability?.startNotifier()
    
    reachability?.whenReachable = { _ in
      NotificationCenter.default.post(name: .whenReachable, object: nil)
    }
    
    reachability?.whenUnreachable = { _ in
      NotificationCenter.default.post(name: .whenUnReachable, object: nil)
    }
  }
  
  func stopMonitoring() {
    reachability?.stopNotifier()
  }
}

extension Notification.Name {
  
  static let whenReachable = Notification.Name("WhenReachableNotification")
  static let whenUnReachable = Notification.Name("WhenUnReachableNotification")
}
