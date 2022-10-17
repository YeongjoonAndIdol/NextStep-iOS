//
//  DetailQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/15.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import RxSwift

import SnapKit
import Then

class DetailQuestVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    var disposeBag: DisposeBag = .init()

    private let titleTextLabel = UILabel().then {
        $0.textColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = NextStapColor.mainColor.color
    }

    private let questTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(AddQuestListCell.self, forCellReuseIdentifier: "addQuestListCell")
    }

    private let doneBackView = UIView().then {
        $0.backgroundColor = NextStapColor.backGroundColor.color
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("루틴 사용하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let heartButton = HeartButton()

    private let heartCountLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
    }
    override func viewDidLoad() {
        addView()
        setLayout()
        configureVC()
    }
    func addView() {
        [
            titleTextLabel,
            cancelButton,
            questTableView,
            doneBackView,
            doneButton,
            heartButton,
            heartCountLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    func setLayout() {
        titleTextLabel.snp.makeConstraints {
            $0.left.equalTo(31)
            $0.top.equalTo(30)
            $0.height.equalTo(35)
        }
        cancelButton.snp.makeConstraints {
            $0.right.equalTo(-31)
            $0.top.equalTo(30)
            $0.width.height.equalTo(48)
        }
        doneBackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.height.equalTo(48)
            $0.left.equalTo(108)
            $0.top.equalTo(doneBackView.snp.top).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        questTableView.snp.makeConstraints {
            $0.top.equalTo(95)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(doneBackView.snp.bottom)
        }
        heartButton.snp.makeConstraints {
            $0.top.equalTo(doneBackView).offset(21)
            $0.left.equalTo(40)
            $0.width.height.equalTo(30)
        }
        heartCountLabel.snp.makeConstraints {
            $0.top.equalTo(heartButton.snp.bottom).offset(1)
            $0.centerX.equalTo(heartButton)
            $0.height.equalTo(19)
        }
    }
    func configureVC() {
        view.backgroundColor = NextStapColor.backGroundColor.color
        doneBackView.makeBackViewShadows()
        // dummy data
        titleTextLabel.text = "서울대생의 하루 루틴"
        heartCountLabel.text = "434"
    }
}
