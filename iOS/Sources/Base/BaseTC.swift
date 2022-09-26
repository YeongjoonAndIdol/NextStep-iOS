//
//  BaseTC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/26.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class BaseTC: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.setLayout()
        self.configureVC()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}

}
