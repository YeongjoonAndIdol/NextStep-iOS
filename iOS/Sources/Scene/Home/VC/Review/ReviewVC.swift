import Foundation
import UIKit
import WebKit
import SnapKit
import Then

class ReviewVC: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    let webViewBackgroundView = UIView()
    var webView = WKWebView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }
    override func viewDidLoad() {
        navigationItem.title = "회고"
        view.backgroundColor = NextStapAsset.Color.backGroundColor.color
        view.addSubview(webViewBackgroundView)
        webViewBackgroundView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        setWebView()
    }

    func setWebView() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self

        contentController.add(self, name: "outLink")
        configuration.userContentController = contentController
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }

    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/review")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        if message.name == "outLink" {
            self.navigationController?.pushViewController(WriteRetrospectVC(), animated: true)
        }
    }
}
