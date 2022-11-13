import UIKit
import SnapKit
import Then

class Example2VC: UIViewController {
    private let imageView = UIImageView().then {
        $0.image = NextStapAsset.Assets.t2.image
    }

    override func viewDidLoad() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(Example3VC(), animated: true)
    }

}
