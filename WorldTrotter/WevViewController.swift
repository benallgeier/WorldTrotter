//
//  WevViewController.swift
//  WorldTrotter
//
//  Created by Benjamin Allgeier on 9/18/16.
//  Copyright © 2016 ballgeier. All rights reserved.
//

//import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        
        // set it as *the* view of this view controller
        view = webView
        
        let url = URL(string: "https://www.bignerdranch.com")
        let urlRequest = URLRequest(url: url!) // note force unwrapping url
        //view.load(urlRequest)  // static member load cannot be used on instance of type UIView
        webView.load(urlRequest)
        
    } // end loadView
} // end WebViewController
