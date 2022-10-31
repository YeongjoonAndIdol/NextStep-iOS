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
        $0.backgroundColor = NextStapColor.buttonDisabledColor.color
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

        idTextFiled.rx.text.bind {
            if $0 == "" {
                self.idTextIsDone.onNext(false)
            } else {
                self.idTextIsDone.onNext(true)
            }
        }.disposed(by: disposeBag)

        passwordTextFiled.rx.text.bind {
            if $0 == "" {
                self.passwordTextIsDone.onNext(false)
            } else {
                self.passwordTextIsDone.onNext(true)
            }
        }.disposed(by: disposeBag)

        Observable.combineLatest(idTextIsDone,
                                 passwordTextIsDone) {$0 && $1 }
            .bind {
                if $0 == true {
                    self.loginButton.backgroundColor = NextStapColor.mainColor.color
                    self.loginButton.isEnabled = true
                } else {
                    self.loginButton.backgroundColor = NextStapColor.buttonDisabledColor.color
                    self.loginButton.isEnabled = false
                }
            }.disposed(by: disposeBag)

    }

    override func bindAction(reactor: LoginReactor) {
        loginButton.rx.tap
            .map { Reactor.Action.loginButtonPress }
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
                let tabBarVC = TabBarVC()
                tabBarVC.modalPresentationStyle = .fullScreen
                self.present(tabBarVC, animated: true)
                // dummy
                if bool {
                    self.present(TabBarVC(), animated: true)
                }
            }.disposed(by: disposeBag)
    }

}
