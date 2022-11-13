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

        contentController.add(self, name: "editOutLink")
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
            if message.name == "editOutLink" {
                self.navigationController?.pushViewController(MyPageDetailVC(), animated: true)
            }
            if message.name == "outLink" {
                let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                sheet.addAction(UIAlertAction(title: "수정", style: .default, handler: nil))
                sheet.addAction(UIAlertAction(title: "삭제", style: .cancel, handler: nil))
                present(sheet, animated: true)
            }
        }
}
