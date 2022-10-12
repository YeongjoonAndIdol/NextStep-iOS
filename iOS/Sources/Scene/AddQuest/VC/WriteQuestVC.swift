//
//  WriteQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/08.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Then

class WriteQuestVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    private var disposeBag: DisposeBag = .init()
    private var categoryNumber = 0

    private let titleTextField = UITextField().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.tintColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }

    private let contentTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.tintColor = NextStapColor.onSurfaceColor.color
        $0.textColor = NextStapColor.textButtonDisabledColor.color
        $0.textContainer.maximumNumberOfLines = 5
    }

    fileprivate let textViewPlaceHolder = "부연 설명 (퀘스트를 자세히 설명해주세요.)"

    private let categoryImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let categoryButtonImage = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = NextStapColor.mainColor.color
        $0.contentMode = .scaleAspectFit
    }

    private let categoryButton = UIButton().then {
        $0.setTitleColor(NextStapColor.mainColor.color, for: .normal)
        $0.setTitle("카테고리 설정", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.buttonDisabledColor.color
        $0.layer.cornerRadius = 10
    }

}
