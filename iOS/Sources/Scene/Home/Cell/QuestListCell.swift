//
//  QuestListCell.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/26.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class QuestListCell: BaseTC {

    let titleLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let checkButton = CheckBox()

    override func addView() {
        [titleLabel, checkButton].forEach {
            contentView.addSubview($0)
        }
        titleLabel.text = "영준이 때리기 + 상현이 조지기"
        contentView.backgroundColor = NextStapColor.backGroundColor.color

    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(15)
            $0.left.equalTo(40)
            $0.right.equalTo(-84)
        }

        checkButton.snp.makeConstraints {
            $0.right.equalTo(-40)
            $0.height.width.equalTo(24)
            $0.centerY.equalTo(contentView)
        }
    }
}
