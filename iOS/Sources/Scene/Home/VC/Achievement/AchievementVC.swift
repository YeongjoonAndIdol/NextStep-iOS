import UIKit
import WebKit
import RxSwift

class AchievementVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var disposeBag: DisposeBag = .init()
    let webViewBackgroundView = UIView()
    var webView = WKWebView()

    private let addbarButton = UIBarButtonItem(
        image: UIImage(systemName: "book.closed"),
        style: .plain,
        target: AddQuestVC.self,
        action: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    override func viewDidLoad() {
        navigationItem.title = "업적"
        navigationItem.rightBarButtonItem = addbarButton
        addbarButton.rx.tap.bind {
            self.navigationController?.pushViewController(ReviewVC(), animated: true)
        }.disposed(by: disposeBag)

        view.backgroundColor = NextStapAsset.Color.backGroundColor.color
        view.addSubview(webViewBackgroundView)
        webViewBackgroundView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        setWebView()
    }

    func setWebView() {
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        configuration.userContentController = contentController
        webViewBackgroundView.addSubview(webView)
        webView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func load() {
        let url = URL(string: "https://nextstep-front.vercel.app/achievement")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
