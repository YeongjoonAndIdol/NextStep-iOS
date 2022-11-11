import UIKit
import WebKit
import SnapKit
import Then

class SearchVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    let webViewBackgroundView = UIView()
    var webView = WKWebView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    override func viewDidLoad() {
        view.backgroundColor = NextStapAsset.Color.backGroundColor.color
        view.addSubview(webViewBackgroundView)
        webViewBackgroundView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        setWebView()
    }

    func setWebView() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        configuration.userContentController = contentController
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }

    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/search")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
