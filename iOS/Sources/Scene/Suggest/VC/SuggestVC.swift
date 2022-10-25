//
//  SuggestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/23.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import WebKit

class SuggestVC: BaseVC<SuggestReactor> {
    var webView: WKWebView!

    override func addView() {
        setupWebView()

        let url = URL(string: "https://nextstep-front.vercel.app/myquest")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v0]|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["v0": webView!]))

        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-20-[v0]|",
                options: NSLayoutConstraint.FormatOptions(),
                metrics: nil,
                views: ["v0": webView!]))
    }

}
