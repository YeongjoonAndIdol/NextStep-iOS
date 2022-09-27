//
//  AllQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/23.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class AllQuestVC: UIViewController {
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
        titleLabel.text = "전체 퀘스트 | 6 개"
        
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
