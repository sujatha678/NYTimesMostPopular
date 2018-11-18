//
//  ArticleDetailViewController.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailViewController: ViewController {
    
    @IBOutlet weak var articleDetailWebview: WKWebView?
    
    var article: ArticleData?
    //Holds the Webview status - to check whether reload is needed or not once the internet is back
    var isWebViewLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Confirms to NaviagationDelegate
        articleDetailWebview?.navigationDelegate = self
    }
    
    //Load Article details in Webview
    func loadArticleDetails() {
        Utils.showActivityIndicator(viewController: self)
        if let url = URL(string: article?.urlString ?? "") {
            articleDetailWebview?.load(URLRequest(url: url))
            articleDetailWebview?.allowsBackForwardNavigationGestures = true
        }
    }
    
    override func updatestatus(_ status: NetworkStatus) {
        super.updatestatus(status)
        if status == .notReachable {
            Utils.showAlert(title: "Alert!", message: "Please check your internet connection", viewController: self)
            Utils.stopActivityIndicator()
            
        } else if !isWebViewLoaded { //As mentioned Load webview again only if not loaded before
            loadArticleDetails()
        }
    }
}

//MARK: - WKNavigationDelegate
extension ArticleDetailViewController: WKNavigationDelegate {
    
    //If loading finished stop HUD if any in case and update isWebViewLoaded
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Utils.stopActivityIndicator()
        isWebViewLoaded = true
    }
    //If loading failed stop HUD
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Utils.showAlert(title: "Alert!", message: "Loading Failure", viewController: self)
        Utils.stopActivityIndicator()
    }
}
