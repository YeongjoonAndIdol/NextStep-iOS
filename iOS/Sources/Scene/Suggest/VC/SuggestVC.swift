import UIKit
import WebKit

class SuggestVC: BaseVC<SuggestReactor>, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    let webViewBackgroundView = UIView()
    var webView = WKWebView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    private let addbarButton = UIBarButtonItem(
        image: UIImage(systemName: "magnifyingglass"),
        style: .plain,
        target: AddQuestVC.self,
        action: nil)

    override func addView() {
        navigationItem.title = "추천 퀘스트"
        navigationItem.rightBarButtonItem = addbarButton

        addbarButton.rx.tap.bind {
            self.navigationController?.pushViewController(SearchVC(), animated: true)
        }.disposed(by: disposeBag)

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
        let url = URL(string: "https://nextstep-front.vercel.app/recommen")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage) {
            print(message.name)
            if message.name == "outLink" {
                let detailVC = DetailQuestVC()
                if #available(iOS 16.0, *) {
                    if let sheet = detailVC.sheetPresentationController {
                        sheet.detents = [.custom { _ in
                            return 700
                        }]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 32
                        self.present(detailVC, animated: true)
                    }
                }
            }
        }
}
