//
//  Shadaw.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/18.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

extension UIView {
    func makeDoneButtonShadows() {
        self.layer.shadowPath = nil
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    func makeBackViewShadows() {
        self.layer.shadowPath = nil
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}
