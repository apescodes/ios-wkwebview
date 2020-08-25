//
//  UIViewController+Alert.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/20/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func showAlert(title: String, text: String) {
    let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    
    present(alert, animated: true, completion: nil)
  }
}
