import Foundation
import UIKit
import SnapKit
import Then

class Example5VC: UIViewController {
    private let imageView = UIImageView().then {
        $0.image = NextStapAsset.Assets.t5.image
    }

    override func viewDidLoad() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(Example6VC(), animated: true)
    }

}
