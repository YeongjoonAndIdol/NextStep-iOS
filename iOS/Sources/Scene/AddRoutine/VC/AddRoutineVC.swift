//
//  AddQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/28.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

protocol AddQuestDelegate: AnyObject {
    func dismissSelectSchoolVC(_ schoolImage: UIImage)
}

class AddRoutineVC: BaseVC<AddRoutineReactor> {

    private let titleTextField = UITextField().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.tintColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 22, weight: .regular)
    }

    private let timeTextLabel = UILabel().then {
        $0.textColor = NextStapColor.textButtonDisabledColor.color
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.text = "기간"
    }

    private let timaePicker = UIDatePicker().then {
        $0.backgroundColor = .white
        $0.tintColor = NextStapColor.onSurfaceColor.color
        $0.preferredDatePickerStyle = .compact
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("퀘스트 생성", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.buttonDisabledColor.color
        $0.layer.cornerRadius = 10
    }

    fileprivate let textViewPlaceHolder = "부연 설명 (루틴을 자세히 설명해주세요.)"

    private let contentTextView = UITextView().then {
        $0.tintColor = NextStapColor.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = NextStapColor.textButtonDisabledColor.color
        $0.textContainer.maximumNumberOfLines = 5
    }

    private let addButtonImage = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = NextStapColor.mainColor.color
        $0.contentMode = .scaleAspectFit
    }

    private let addButton = UIButton().then {
        $0.setTitleColor(NextStapColor.mainColor.color, for: .normal)
        $0.setTitle("학교 설정", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }

    let schoolImageView = UIImageView()

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func addView() {
        self.navigationItem.title = "루틴 생성"

        [
            titleTextField,
            timeTextLabel,
            timaePicker,
            contentTextView,
            addButtonImage,
            addButton,
            schoolImageView,
            doneButton
        ].forEach {
            view.addSubview($0)
        }
    }

    override func configureVC() {

        contentTextView.text = textViewPlaceHolder
        contentTextView.delegate = self

        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "제목",
            attributes: [NSAttributedString.Key.foregroundColor: NextStapColor.textButtonDisabledColor.color,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular)]
        )

        if #available(iOS 16.0, *) {
            addButton.rx.tap
                .bind {
                    let selectSchoolVC = SelectSchoolVC()
                    if let sheet = selectSchoolVC.sheetPresentationController {
                        sheet.detents = [.custom { _ in
                            return 310
                        }]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 32
                        selectSchoolVC.delegate = self
                        self.present(selectSchoolVC, animated: true)
                    }
                }.disposed(by: disposeBag)
        }
    }

    override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(42)
            $0.leading.trailing.equalTo(view).inset(40)
            $0.height.equalTo(35)
        }
        timeTextLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(59)
            $0.left.equalTo(40)
            $0.height.equalTo(29)
        }
        timaePicker.snp.makeConstraints {
            $0.centerY.equalTo(timeTextLabel)
            $0.right.equalTo(-40)
        }
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(36)
            $0.top.equalTo(timeTextLabel.snp.bottom).offset(60)
            $0.bottom.equalTo(doneButton.snp.top).offset(-200)
        }

        addButtonImage.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalTo(contentTextView.snp.bottom).offset(32)
            $0.leading.equalTo(40)
        }
        schoolImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalTo(40)
            $0.top.equalTo(addButtonImage.snp.bottom).offset(20)
        }
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(addButtonImage)
            $0.leading.equalTo(72)
        }
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.height.equalTo(48)
        }
    }
}

extension AddRoutineVC: UITextViewDelegate {

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
extension AddRoutineVC: AddQuestDelegate {
    func dismissSelectSchoolVC(_ schoolImage: UIImage) {
        schoolImageView.image = schoolImage
    }
}
