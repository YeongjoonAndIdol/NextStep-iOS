import UIKit
import WebKit
import SnapKit
import Then

class MyPageDetailVC: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
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
        webView.uiDelegate = self
        webView.navigationDelegate = self

        contentController.add(self, name: "outLink")
        configuration.userContentController = contentController
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }

    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/setting")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage) {
            // outLink
            print(message.name)
            if message.name == "outLink" {
                let sheet = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까??", preferredStyle: .actionSheet)
                sheet.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
                sheet.addAction(UIAlertAction(title: "로그아웃", style: .cancel, handler: { _ in
                    print("yes 클릭")
                }))
                present(sheet, animated: true)
            }
        }

}
