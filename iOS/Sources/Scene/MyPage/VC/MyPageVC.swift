import UIKit
import WebKit

class MyPageVC: BaseVC<MyPageReactor> {
    var webView: WKWebView!

    override func addView() {
        setupWebView()

        let url = URL(string: "https://nextstep-front-94xsj5if3-nextstepdms.vercel.app/mypage")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
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
extension MyPageVC: WKUIDelegate, WKNavigationDelegate {}
