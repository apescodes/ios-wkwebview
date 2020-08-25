//
//  ViewController.swift
//  ios-web-client
//
//  Created by Nazar Yavornytskyi on 8/20/20.
//  Copyright © 2020 apescodes. All rights reserved.
//

import UIKit
import WebKit

final class MainViewController: UIViewController {
  
  private var bridge: CaseRoyaleWebBridge?
  private let service = SetupService()
  
  lazy var configuration: WKWebViewConfiguration = {
    let preferences = WKPreferences()
    preferences.javaScriptEnabled = true
    
    let config = WKWebViewConfiguration()
    config.preferences = preferences
    
    return config
  }()
  
  private lazy var webView: WKWebView = {
    WKWebView(frame: .zero, configuration: configuration)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .black
    webView.backgroundColor = .black
    
    bridge = CaseRoyaleWebBridge(webView: webView)
    
    prepare()
  }
  
  // MARK: - Private
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    webView.frame = view.bounds
  }
  
  private func prepare() {
    setupWebView()
    
    NotificationCenter.default.addObserver(self, selector: #selector(loadPage), name: .whenReachable, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loadPage), name: .whenUnReachable, object: nil)
  }
  
  private func setupWebView() {
    webView.navigationDelegate = self
    view.addSubview(webView)
    
    loadPage()
  }
  
  @objc private func loadPage(_ defaultHTTPPage: String = "disconnected") {
    if service.isConnected {
      if let url = URL(string: API.gameUrl) {
        webView.load(URLRequest(url: url))
      }
    } else {
      if let url = Bundle.main.url(forResource: defaultHTTPPage, withExtension: "html", subdirectory: nil) {
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
      }
    }
  }
}

extension MainViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("started page loading")
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("finished page loading")
    let url = webView.url?.absoluteString
    if url?.contains("file:///") == false && !service.isConnected {
      loadPage()
    }
    
    bridge?.adService.updateState()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    print("failed in page - \(error.localizedDescription)")
    let url = webView.url?.absoluteString
    if url?.contains("file:///") == false && url?.contains("socket.io") == false {
      loadPage("technical-work")
    }
    
    showAlert(title: "Error", text: error.localizedDescription)
  }
}

extension MainViewController: WKScriptMessageHandler {
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    print("LOG WKWebView: \(message.body)")
  }
}

