//
//  UIStackView+.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/02.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

extension UIStackView {
    @discardableResult func removeAllArrangedSubviews() -> [UIView] {   // stack Array 초기화
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}
