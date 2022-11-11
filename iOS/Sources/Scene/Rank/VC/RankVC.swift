import UIKit
import WebKit

class RankVC: BaseVC<RankReactor>, WKNavigationDelegate, WKUIDelegate {
    let webViewBackgroundView = UIView()
    var webView = WKWebView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    override func addView() {
        view.addSubview(webViewBackgroundView)
        webViewBackgroundView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        setWebView()
    }

    func setWebView() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }

    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/ranking")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
