//
//  SignUpVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/13.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC<SignUpReactor> {

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
        $0.backgroundColor = NextStapColor.subColor3.color
        $0.layer.cornerRadius = 10
    }

    override func addView() {
        [
            doneButton
        ].forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(54)
        }
        doneButton.makeDoneButtonShadows()
    }

}
