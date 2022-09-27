//
//  CompleteQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/23.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class CompleteQuestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return QuestListCell()
    }

    private let titleLabel = UILabel().then {
        $0.textColor = NextStapAsset.Color.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(QuestListCell.self, forCellReuseIdentifier: "PostCell")
    }

    override func viewDidLoad() {

        [
            titleLabel,
            tableView
        ].forEach {
            view.addSubview($0)
        }
        titleLabel.text = "완료 퀘스트 | 9 개"

        tableView.delegate = self
        tableView.dataSource = self

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.left.equalTo(40)
            $0.height.equalTo(28)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(76)
        }
    }

}
