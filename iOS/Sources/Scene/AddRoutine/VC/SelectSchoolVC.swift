import UIKit
import RxSwift
import SnapKit
import Then

class SelectSchoolVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    var disposeBag: DisposeBag = .init()

    private let schoolImage: [UIImage] = [
        NextStapImage.elementarySchoolImage.image,
        NextStapImage.middleSchoolImage.image,
        NextStapImage.highSchoolImage.image
    ]

    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
    }

    weak var delegate: AddRoutineDelegate?

    override func viewDidLoad() {

        view.backgroundColor = NextStapColor.backGroundColor.color

        stackView.removeAllArrangedSubviews()

        for count in 0..<schoolImage.count {

            let view = UIView()
            let button = UIButton()

            let imageView = UIImageView().then {
                $0.contentMode = .scaleAspectFit
                $0.image = schoolImage[count]
            }

            [imageView, button].forEach {
                view.addSubview($0)
                $0.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            stackView.addArrangedSubview(view)
            button.rx.tap.bind {
                self.delegate?.dismissSelectSchoolVC(self.schoolImage[count])
                self.dismiss(animated: true)
            }.disposed(by: disposeBag)
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(105)
            $0.leading.trailing.equalTo(view).inset(40)
            $0.height.equalTo(100)
        }
    }
}
