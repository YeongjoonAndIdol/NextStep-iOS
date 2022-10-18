//
//  WriteRetrospectVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/17.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Then

class WriteRetrospectVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    var disposeBag: DisposeBag = .init()

    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = NextStapColor.mainColor.color
    }
    private let practiceRateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = NextStapColor.mainColor.color
    }

    fileprivate let textViewPlaceHolder = "회고 작성"

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("루틴 사용하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let contentTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.tintColor = NextStapColor.onSurfaceColor.color
        $0.textColor = NextStapColor.textButtonDisabledColor.color
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        self.navigationItem.title = "회고 작성"
        dateLabel.text = "2022.9.15 (목)"
        practiceRateLabel.text = "3/5"
        view.backgroundColor = NextStapColor.backGroundColor.color
        contentTextView.text = textViewPlaceHolder
        contentTextView.delegate = self

        [
            dateLabel,
            practiceRateLabel,
            doneButton,
            contentTextView
        ].forEach {
            view.addSubview($0)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
            $0.leading.equalTo(30)
            $0.height.equalTo(25)
        }
        practiceRateLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel.snp.right).offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
            $0.height.equalTo(25)
        }
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.bottom.equalTo(doneButton.snp.top).offset(-30)
        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(48)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
    }
}

extension WriteRetrospectVC: UITextViewDelegate {
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
