import UIKit

class SignUpVC: BaseVC<SignUpReactor> {

    private let signInLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private let nameTextFieldBackView = UIView()
    private let idTextFieldBackView = UIView()
    private let passwordTextFieldBackView = UIView()

    private let nameTextField = UITextField()
    private let idTextField = UITextField()
    private let passwordTextField = UITextField()

    private let nameBottomLabel = UILabel()
    private let idBottomLabel = UILabel()
    private let passwordBottomLabel = UILabel()

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    override func addView() {

        [
            signInLabel,
            doneButton,
            nameTextFieldBackView,
            idTextFieldBackView,
            passwordTextFieldBackView,
            nameBottomLabel,
            idBottomLabel,
            passwordBottomLabel
        ]
            .forEach {
            view.addSubview($0)
        }

        nameTextFieldBackView.addSubview(nameTextField)
        idTextFieldBackView.addSubview(idTextField)
        passwordTextFieldBackView.addSubview(passwordTextField)
    }

    override func configureVC() {

        [nameTextFieldBackView, idTextFieldBackView, passwordTextFieldBackView].forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = NextStapColor.gary2.color.cgColor
            $0.backgroundColor = NextStapColor.surfaceColor.color
        }

        [nameBottomLabel, idBottomLabel, passwordBottomLabel].forEach {
            $0.textColor = NextStapColor.errorColor.color
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }

        [nameTextField, idTextField, passwordTextField].forEach {
            $0.textColor = NextStapColor.onSurfaceColor.color
            $0.tintColor = NextStapColor.mainColor.color
        }

        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "이름을 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color]
        )

        idTextField.attributedPlaceholder = NSAttributedString(
            string: "아이디를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color]
        )

        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color]
        )

    }

    override func setLayout() {
        signInLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(30)
            $0.height.equalTo(32)
        }

        nameTextFieldBackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(idTextFieldBackView.snp.top).offset(-40)
        }

        idTextFieldBackView.snp.makeConstraints {
            $0.centerY.equalTo(view).offset(-80)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        passwordTextFieldBackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
            $0.top.equalTo(idTextFieldBackView.snp.bottom).offset(40)
        }

        [nameTextField, idTextField, passwordTextField].forEach { textField in
            textField.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.bottom.equalToSuperview().inset(11)
            }
        }

        let bottomLabel: [UILabel] = [nameBottomLabel, idBottomLabel, passwordBottomLabel]
        let textFieldBackView: [UIView] = [nameTextFieldBackView, idTextFieldBackView, passwordTextFieldBackView]

        for count in 0..<3 {
            bottomLabel[count].snp.makeConstraints {
                $0.leading.trailing.equalTo(0).inset(19)
                $0.height.equalTo(12)
                $0.top.equalTo(textFieldBackView[count].snp.bottom).offset(8)
            }
        }

        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(54)
        }

    }

    override func bindAction(reactor: SignUpReactor) {
        doneButton.rx.tap
            .map { Reactor.Action.signUpButtonPress }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func bindState(reactor: SignUpReactor) {
        reactor.state
            .map { $0.id }
            .distinctUntilChanged()
            .bind(to: idTextField.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.passWord }
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.name }
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.isNavigate }
            .bind { bool in
                if bool {
                    self.navigationController?.popViewController(animated: true)
                }
            }.disposed(by: disposeBag)
    }
}
