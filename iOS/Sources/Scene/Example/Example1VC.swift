import UIKit
import SnapKit
import Then
import RxSwift

class Example1VC: UIViewController {
    private let disposeBag: DisposeBag = .init()

    private let imageView = UIImageView().then {
        $0.image = NextStapAsset.Assets.t1.image
    }
    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapAsset.Color.surfaceColor.color, for: .normal)
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapAsset.Color.mainColor.color
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(Example2VC(), animated: true)
    }
}
