import UIKit
import RxSwift

class LoginVC: BaseVC<LoginReactor> {
    private let idTextIsDone = BehaviorSubject<Bool>(value: false)
    private let passwordTextIsDone = BehaviorSubject<Bool>(value: false)

    private let logoLabel = UILabel().then {
        $0.text = "Next Stap"
        $0.textColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    private let idTextFiledBackView = UIView()
    private let passwordTextFiledBackView = UIView()

    private let idTextFiled = UITextField()
    private let passwordTextFiled = UITextField()

    private let loginButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let loginBottomLine = UIView().then {
        $0.backgroundColor = NextStapColor.gary2.color
    }

    private let signInGoogleButton = UIButton().then {
        $0.setTitleColor(NextStapColor.onSurfaceColor.color, for: .normal)
        $0.setTitle("Sign in with Google", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.surfaceColor.color
        $0.layer.cornerRadius = 10
    }

    private let googleLogo = UIImageView().then {
        $0.image = NextStapImage.googleLogo.image
    }

    private let signUpButton = UIButton().then {
        $0.setTitleColor(NextStapColor.textButtonDisabledColor.color, for: .normal)
        $0.setTitle("아직 회원이 아니신가요? 회원가입하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }

     override func addView() {

        [
            logoLabel,
            idTextFiledBackView,
            passwordTextFiledBackView,
            loginButton,
            loginBottomLine,
            signInGoogleButton,
            signUpButton
        ]
             .forEach {
            view.addSubview($0)
        }

         idTextFiled.text = ""
         passwordTextFiled.text = ""
         idTextFiledBackView.addSubview(idTextFiled)
         passwordTextFiledBackView.addSubview(passwordTextFiled)
         signInGoogleButton.addSubview(googleLogo)

    }

    override func configureVC() {

        [idTextFiledBackView, passwordTextFiledBackView].forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = NextStapColor.gary2.color.cgColor
            $0.backgroundColor = NextStapColor.surfaceColor.color
        }

        [idTextFiled, passwordTextFiled].forEach {
            $0.textColor = NextStapColor.onSurfaceColor.color
            $0.tintColor = NextStapColor.mainColor.color
        }

        idTextFiled.attributedPlaceholder = NSAttributedString(
            string: "아이디를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color]
        )

        passwordTextFiled.attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color]
        )

        passwordTextFiled.isSecureTextEntry = true
    }

    override func setLayout() {
        logoLabel.snp.makeConstraints {
            $0.left.equalTo(33)
            $0.height.equalTo(35)
            $0.bottom.equalTo(idTextFiledBackView.snp.top).offset(-20)
        }

        loginButton.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        passwordTextFiledBackView.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-37)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        idTextFiledBackView.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextFiledBackView.snp.top).offset(-24)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        [idTextFiled, passwordTextFiled].forEach { textField in
            textField.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.bottom.equalToSuperview().inset(11)
            }
        }

        loginBottomLine.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(38)
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(view).inset(24)
        }

        signInGoogleButton.snp.makeConstraints {
            $0.top.equalTo(loginBottomLine.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        googleLogo.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.centerY.equalTo(signInGoogleButton)
            $0.width.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-36)
            $0.height.equalTo(22)
            $0.centerX.equalTo(view)
        }

    }

    override func bindView(reactor: LoginReactor) {
        signUpButton.rx.tap.bind { _ in
            self.navigationController?.pushViewController(SignUpVC(reactor: SignUpReactor()), animated: true)
        }.disposed(by: disposeBag)

    }

    override func bindAction(reactor: LoginReactor) {
        loginButton.rx.tap
            .bind {
                NextStapAPI.signIn(req: SigninRequestDTO(
                    accountID: self.idTextFiled.text!,
                    password: self.passwordTextFiled.text!))
                .request()
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        let example1VC = BaseNC(rootViewController: Example1VC())
                        example1VC.modalPresentationStyle = .fullScreen
                         self.present(example1VC, animated: true)
                        if let data = try? JSONDecoder().decode(TokenResponseDTO.self, from: response.data) {
                            KeyChain.create(key: KeyChainDTO.accessToken, token: data.accessToken)
                            KeyChain.create(key: KeyChainDTO.refreshToken, token: data.refreshToken)
                        }
                    case .failure(let error):
                        print(error)
                        let sheet = UIAlertController(
                            title: "Login 실폐",
                            message: "아이디 비밀번호가 일치하지 않습니다.",
                            preferredStyle: .alert)
                        sheet.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                        self.present(sheet, animated: true)
                    }
                }.disposed(by: self.disposeBag)

            }
            .disposed(by: disposeBag)

        idTextFiled.rx.text
            .map { Reactor.Action.updateID($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        passwordTextFiled.rx.text
            .map { Reactor.Action.updatePassWord($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func bindState(reactor: LoginReactor) {
        reactor.state
            .map { $0.id }
            .distinctUntilChanged()
            .bind(to: idTextFiled.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.passWord }
            .distinctUntilChanged()
            .bind(to: passwordTextFiled.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.isNavigate }
            .bind { bool in
                print(bool)
                if bool {
                    let example1VC = BaseNC(rootViewController: Example1VC())
                    example1VC.modalPresentationStyle = .fullScreen
                     self.present(example1VC, animated: true)
                }
            }.disposed(by: disposeBag)
    }

}
