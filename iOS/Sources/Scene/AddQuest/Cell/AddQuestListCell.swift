//
//  AddQuestListCell.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/12.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class AddQuestListCell: BaseTC {

    let leftBar = UIView().then {
        $0.layer.cornerRadius = 2
    }

    let categoryImage = UIImageView()

    let categorytextLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = NextStapColor.onSurfaceColor.color
    }

    let questTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
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

        contentView.backgroundColor = NextStapColor.surfaceColor.color
        leftBar.backgroundColor = NextStapColor.subColor3.color
        categoryImage.image = NextStapImage.small3.image
        categorytextLabel.text = "자율활동"
        questTitleLabel.text = "영준이 죽이기"
        contentTextLabel.text = "연예하는 영준이를 죽이는 활동을 해보아요"

    }

    override func setLayout() {
        leftBar.snp.makeConstraints {
            $0.leading.equalTo(30)
            $0.top.bottom.equalTo(contentView).inset(5)
            $0.width.equalTo(4)
        }
        categoryImage.snp.makeConstraints {
            $0.leading.equalTo(44)
            $0.width.height.equalTo(19)
            $0.top.equalTo(4)
        }
        categorytextLabel.snp.makeConstraints {
            $0.leading.equalTo(70)
            $0.top.equalTo(4)
            $0.height.equalTo(19)
            $0.trailing.equalTo(-16)
        }
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categorytextLabel.snp.bottom).offset(11)
            $0.leading.equalTo(44)
            $0.trailing.equalTo(-44)
            $0.height.equalTo(22)
        }
        contentTextLabel.snp.makeConstraints {
            $0.top.equalTo(questTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(44)
            $0.trailing.equalTo(-44)
        }
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextLabel.snp.bottom).offset(4)
            $0.leading.equalTo(44)
            $0.trailing.equalTo(-44)
            $0.height.equalTo(16)
            $0.bottom.equalTo(-2)
        }
    }
}
