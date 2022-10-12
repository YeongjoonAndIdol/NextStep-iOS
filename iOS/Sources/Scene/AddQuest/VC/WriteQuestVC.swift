//
//  WriteQuestVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/08.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
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
