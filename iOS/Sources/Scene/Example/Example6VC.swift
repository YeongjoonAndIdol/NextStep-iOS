//
//  Example6VC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/11/12.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxSwift

class Example6VC: UIViewController {
    private let disposeBag: DisposeBag = .init()

    private let imageView = UIImageView().then {
        $0.image = NextStapAsset.Assets.t6.image
    }
    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapAsset.Color.surfaceColor.color, for: .normal)
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapAsset.Color.mainColor.color
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        view.addSubview(imageView)
        view.addSubview(doneButton)

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.height.equalTo(48)
        }
        doneButton.rx.tap.bind {
            let tabBarVC = TabBarVC()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }.disposed(by: disposeBag)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBarVC = TabBarVC()
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true)
    }

}
