//
//  AddQuestListCell.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/12.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class AddQuestListCell: BaseTC {

    let leftBar = UIView()
    let categoryImage = UIImageView()

    let categorytextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = NextStapColor.onSurfaceColor.color
    }

    let questTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = NextStapColor.onSurfaceColor.color
    }

    let contentTextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.numberOfLines = 0
    }

    let pointLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = NextStapColor.onSurfaceColor.color
    }

    override func addView() {
        [
            leftBar,
            categoryImage,
            categorytextLabel,
            questTitleLabel,
            contentTextLabel,
            pointLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }

    override func setLayout() {
        leftBar.snp.makeConstraints {
            $0.leading.equalTo(30)
            $0.top.bottom.equalTo(0)
            $0.width.equalTo(4)
        }
        categoryImage.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.width.height.equalTo(24)
            $0.top.equalTo(1)
        }
        categorytextLabel.snp.makeConstraints {
            $0.leading.equalTo(52)
            $0.top.equalTo(4)
            $0.height.equalTo(19)
            $0.trailing.equalTo(-16)
        }
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categorytextLabel.snp.bottom).offset(11)
            $0.leading.equalTo(14)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(22)
        }
        contentTextLabel.snp.makeConstraints {
            $0.top.equalTo(questTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(14)
            $0.trailing.equalTo(-16)
        }
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextLabel.snp.bottom).offset(4)
            $0.leading.equalTo(14)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(16)
            $0.bottom.equalTo(2)
        }
    }
}
