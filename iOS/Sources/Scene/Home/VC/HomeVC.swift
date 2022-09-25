//
//  HomeVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/21.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class HomeVC: BaseVC<HomeReactor> {

    private let titleLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.text = "루틴/퀘스트"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    private let addButton = UIButton()
    private let achievementButton = UIButton()

    private let questContainerView = UIView()
    private let questTabView = QuestTaBarView()

    override func addView() {
        [
            titleLabel,
            addButton,
            achievementButton,
            questContainerView
        ].forEach {
            view.addSubview($0)
        }
        addChild(questTabView)
        view.addSubview(questTabView.view)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(40)
            $0.height.equalTo(35)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }

        addButton.snp.makeConstraints {
            $0.right.equalTo(view).offset(-84)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel)
        }

        achievementButton.snp.makeConstraints {
            $0.right.equalTo(view).offset(-16)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel)
        }

        questTabView.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(view.snp.centerY).offset(126)
        }

    }
}
