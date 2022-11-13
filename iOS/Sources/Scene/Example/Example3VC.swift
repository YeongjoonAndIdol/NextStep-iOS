import UIKit
import SnapKit
import Then

class Example3VC: UIViewController {
    private let imageView = UIImageView().then {
        $0.image = NextStapAsset.Assets.t3.image
    }

    override func viewDidLoad() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(Example4VC(), animated: true)
    }

}
