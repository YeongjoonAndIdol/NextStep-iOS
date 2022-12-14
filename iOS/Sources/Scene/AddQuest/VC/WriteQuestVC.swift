import UIKit
import RxSwift
import RxRelay
import SnapKit
import Then
import Moya

class WriteQuestVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    private var disposeBag: DisposeBag = .init()
    private var categoryNumber = 0

    var questID: String = ""
    var typeString: String = ""

    private let titleTextIsDone = BehaviorSubject<Bool>(value: false)
    private let contentTextIsDone = BehaviorSubject<Bool>(value: false)
    private let categoryIsDone = BehaviorSubject<Bool>(value: false)

    var questArray: [CategoryModel] = []
    weak var delegate: AddQuestDelegate?

    private let titleTextField = UITextField().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.tintColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    private let contentTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.tintColor = NextStapColor.onSurfaceColor.color
        $0.textColor = NextStapColor.textButtonDisabledColor.color
        $0.textContainer.maximumNumberOfLines = 5
    }

    fileprivate let textViewPlaceHolder = "부연 설명 (퀘스트를 자세히 설명해주세요.)"

    private let categoryImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let categoryButtonImage = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = NextStapColor.mainColor.color
        $0.contentMode = .scaleAspectFit
    }

    private let categoryButton = UIButton().then {
        $0.setTitleColor(NextStapColor.mainColor.color, for: .normal)
        $0.setTitle("카테고리 설정", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.buttonDisabledColor.color
        $0.layer.cornerRadius = 10
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
    }

    override func viewDidLoad() {
        view.backgroundColor = NextStapColor.backGroundColor.color
        contentTextView.text = textViewPlaceHolder
        contentTextView.delegate = self

        [
            titleTextField,
            contentTextView,
            categoryImageView,
            categoryButtonImage,
            categoryButton,
            doneButton
        ].forEach {
            view.addSubview($0)
        }

        setLayout()
        configureVC()
        setMenu()
        bind()
    }

    private func configureVC() {
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "퀘스트 제목",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular)]
        )
    }

    private func setMenu() {
        let menu1 = UIAction(title: "운동", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("운동", for: .normal)
            self.categoryImageView.image = NextStapImage.category1.image
            self.categoryNumber = 1
        })
        let menu2 = UIAction(title: "공부", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("공부", for: .normal)
            self.categoryImageView.image = NextStapImage.category2.image
            self.categoryNumber = 2
        })
        let menu3 = UIAction(title: "생활패턴", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("생활패턴", for: .normal)
            self.categoryImageView.image = NextStapImage.category3.image
            self.categoryNumber = 3
        })
        let menu4 = UIAction(title: "취미", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("취미", for: .normal)
            self.categoryImageView.image = NextStapImage.category4.image
            self.categoryNumber = 4
        })
        let menu5 = UIAction(title: "독서", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("독서", for: .normal)
            self.categoryImageView.image = NextStapImage.category5.image
            self.categoryNumber = 5
        })
        let menu6 = UIAction(title: "환경", handler: {_ in
            self.categoryIsDone.onNext(true)
            self.categoryButton.setTitle("환경", for: .normal)
            self.categoryImageView.image = NextStapImage.category6.image
            self.categoryNumber = 6
        })

        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.menu = UIMenu(
            options: .displayInline,
            children: [
                menu1,
                menu2,
                menu3,
                menu4,
                menu5,
                menu6
            ])
    }

    private func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(70)
            $0.height.equalTo(32)
            $0.leading.trailing.equalTo(view).inset(40)
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(22)
            $0.leading.trailing.equalTo(titleTextField)
            $0.bottom.equalTo(-250)
        }

        categoryImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.bottom.equalTo(categoryButtonImage.snp.top).offset(-15)
            $0.leading.equalTo(16)
        }

        categoryButtonImage.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.bottom.equalTo(doneButton.snp.top).offset(-26)
            $0.leading.equalTo(16)
        }

        categoryButton.snp.makeConstraints {
            $0.centerY.equalTo(categoryButtonImage)
            $0.leading.equalTo(48)
        }

        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.height.equalTo(48)
        }
    }

    func bind() {

        titleTextField.rx.text.bind {
            if $0 == "" {
                self.titleTextIsDone.onNext(false)
            } else {
                self.titleTextIsDone.onNext(true)
            }
        }.disposed(by: disposeBag)

        contentTextView.rx.text.bind {
            if $0 == "" || $0 == self.textViewPlaceHolder {
                self.contentTextIsDone.onNext(false)
            } else {
                self.contentTextIsDone.onNext(true)
            }
        }.disposed(by: disposeBag)

        Observable.combineLatest(titleTextIsDone,
                                 contentTextIsDone,
                                 categoryIsDone) {$0 && $1 && $2}
            .bind {
                if $0 == true {
                    self.doneButton.backgroundColor = NextStapColor.mainColor.color
                    self.doneButton.isEnabled = true
                } else {
                    self.doneButton.backgroundColor = NextStapColor.buttonDisabledColor.color
                    self.doneButton.isEnabled = false
                }
            }.disposed(by: disposeBag)

        doneButton.rx.tap.bind {
            self.appendQuestList(categoryNum: self.categoryNumber)
            self.delegate?.dismissWriteQuestVC(self.questArray)
            self.dismiss(animated: true)

            NextStapAPI.addList(
                questID: self.questID,
                req: .init(
                    title: (self.titleTextField.text!),
                    content: self.contentTextView.text!,
                    type: self.typeString
                )
            )
            .request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    print(response.statusCode)
                    self.appendQuestList(categoryNum: self.categoryNumber)
                    self.delegate?.dismissWriteQuestVC(self.questArray)
                    self.dismiss(animated: true)
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}

extension WriteQuestVC: UITextViewDelegate {

    func appendQuestList(categoryNum: Int) {
        switch categoryNum {
        case 1:
            questArray.append(Category.SPORT.toQuestModel(titleTextField.text!,
                                                          contentTextView.text))
        case 2:
            questArray.append(Category.STUDY.toQuestModel(titleTextField.text!,
                                                          contentTextView.text))
        case 3:
            questArray.append(Category.LIFE.toQuestModel(titleTextField.text!,
                                                         contentTextView.text))
        case 4:
            questArray.append(Category.HOBBY.toQuestModel(titleTextField.text!,
                                                          contentTextView.text))
        case 5:
            questArray.append(Category.BOOK.toQuestModel(titleTextField.text!,
                                                         contentTextView.text))
        case 6:
            questArray.append(Category.ENVIRONMENT.toQuestModel(titleTextField.text!,
                                                                contentTextView.text))
        default:
            break
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = NextStapColor.onSurfaceColor.color
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = NextStapColor.textButtonDisabledColor.color
        }
    }

}
