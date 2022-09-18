//
//  LoginVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/06.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class LoginVC: BaseVC<LoginReactor> {

//    private let logoImage = UIImageView().then {
//        $0.image = NextStapImage.loginLogo.image
//    }

    private let logoImage = UIImageView()

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

     override func addView() {

        [
            logoImage,
            logoLabel,
            idTextFiledBackView,
            passwordTextFiledBackView,
            loginButton,
            signInGoogleButton
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

        loginButton.rx.tap.bind { _ in
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        }.disposed(by: disposeBag)

    }

    override func setLayout() {

        logoImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.left.equalTo(32)
            $0.width.height.equalTo(64)
        }

        logoLabel.snp.makeConstraints {
//            $0.top.equalTo(logoImage.snp.bottom)
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

        signInGoogleButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(36)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }

        googleLogo.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.centerY.equalTo(signInGoogleButton)
            $0.width.height.equalTo(50)
        }

    }

}
