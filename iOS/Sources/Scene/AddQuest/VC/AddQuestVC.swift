//
//  AddQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/06.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class AddQuestVC: BaseVC<AddQuestReactor> {
    private let questTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.buttonDisabledColor.color
        $0.layer.cornerRadius = 10
    }

    private let addbarButton = UIBarButtonItem(
        title: "추가",
        style: .plain,
        target: AddQuestVC.self,
        action: nil)

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func addView() {
        [
            questTableView,
            doneButton
        ].forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        questTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.height.equalTo(48)
        }
    }

    override func configureVC() {

        navigationItem.title = "퀘스트 생성"
        navigationItem.rightBarButtonItem = addbarButton

        if #available(iOS 16.0, *) {
            addbarButton.rx.tap.bind {
                let writeQuestVC = WriteQuestVC()
                if let sheet = writeQuestVC.sheetPresentationController {
                    sheet.detents = [.custom { _ in
                        return 700
                    }]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 32
                    self.present(writeQuestVC, animated: true)
                }
            }.disposed(by: disposeBag)
        }

    }

}
