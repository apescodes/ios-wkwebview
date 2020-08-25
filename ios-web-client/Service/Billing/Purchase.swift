//
//  Purchase.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/21/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import Foundation
import SwiftyStoreKit

final class Purchase: BillingService {
  
  func getProducts(productIds: [String]) {
    SwiftyStoreKit.retrieveProductsInfo(Set<String>(productIds)) { result in
      if let product = result.retrievedProducts.first {
        let priceString = product.localizedPrice!
        print("Product: \(product.localizedDescription), price: \(priceString)")
      }
      else if let invalidProductId = result.invalidProductIDs.first {
        print("Invalid product identifier: \(invalidProductId)")
      }
      else {
        print("Error: \(result.error)")
      }
    }
  }
  
  func purchase(productID: String, callback: @escaping Delegate<Bool, String?>) {
    SwiftyStoreKit.purchaseProduct(productID) { result in
      self.handlePurchase(result: result, callback: callback)
    }
  }
  
  private func handlePurchase(result: PurchaseResult, callback: @escaping Delegate<Bool, String?>) {
    switch result {
    case .success(let purchase):
      let success = "Purchase Success: \(purchase.productId)"
      print(success)
      callback(true, success)
    case .error(let error):
        switch error.code {
        case .unknown:
          let error = "Unknown error. Please contact support"
          print(error)
          callback(false, error)
        case .clientInvalid:
          let error = "Not allowed to make the payment"
          print(error)
          callback(false, error)
        case .paymentCancelled:
          let error = "Not allowed to make the payment"
          print(error)
          callback(false, error)
        case .paymentInvalid:
          let error = "The purchase identifier was invalid"
          print(error)
          callback(false, error)
        case .paymentNotAllowed:
          let error = "The device is not allowed to make the payment"
          print(error)
          callback(false, error)
        case .storeProductNotAvailable:
          let error = "The product is not available in the current storefront"
          print(error)
          callback(false, error)
        case .cloudServicePermissionDenied:
          let error = "Access to cloud service information is not allowed"
          print(error)
          callback(false, error)
        case .cloudServiceNetworkConnectionFailed:
          let error = "Could not connect to the network"
          print(error)
          callback(false, error)
        case .cloudServiceRevoked:
          let error = "User has revoked permission to use this cloud service"
          print(error)
          callback(false, error)
        default:
          let error = (error as NSError).localizedDescription
          print(error)
          callback(false, error)
        }
    }
  }
}
