import UIKit
import WebKit

class MyPageVC: BaseVC<MyPageReactor>, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
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
        webView.uiDelegate = self
        webView.navigationDelegate = self

        contentController.add(self, name: "outLink")
        configuration.userContentController = contentController

        webView.scrollView.isScrollEnabled = false
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/mypage")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage) {
            // outLink
            print(message.name)
            if message.name == "outLink" {
                self.navigationController?.pushViewController(MyPageDetailVC(), animated: true)
            }
        }

}
