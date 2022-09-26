//
//  QuestTaBarView.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/23.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Tabman
import Pageboy

import Then
import SnapKit
import UIKit

class QuestTaBarView: TabmanViewController {

    typealias NextStapColor = NextStapAsset.Color

    private var viewControllers: [UIViewController] = []

    private let VC1 = AllQuestVC()
    private let VC2 = InCompleteQuestVC()
    private let VC3 = CompleteQuestVC()

    private let backLine = UIView().then {
        $0.backgroundColor = NextStapColor.gary3.color
    }

    private let bottomLine = UIView().then {
        $0.backgroundColor = NextStapColor.gary3.color
    }

    override func viewDidLoad() {

        [backLine, bottomLine].forEach {
            view.addSubview($0)
        }

        super.viewDidLoad()

        [VC1, VC2, VC3].forEach {
            viewControllers.append($0)
        }

        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()

        bar.backgroundView.style = .clear

        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
        bar.layout.interButtonSpacing = view.bounds.width / 6

        bar.indicator.weight = .custom(value: 1)
        bar.indicator.overscrollBehavior = .none
        bar.indicator.tintColor = NextStapColor.onSurfaceColor.color

        bar.buttons.customize {
            $0.tintColor = NextStapColor.gary3.color
            $0.selectedTintColor = NextStapColor.onSurfaceColor.color
            $0.font = .systemFont(ofSize: 14, weight: .semibold)
            $0.selectedFont = .systemFont(ofSize: 14, weight: .semibold)
        }

        // Add to view
        addBar(bar, dataSource: self, at: .top)

        backLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(bar.frame.height - 1)
            $0.height.equalTo(1)
        }

        bottomLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }

    }
}

extension QuestTaBarView: PageboyViewControllerDataSource, TMBarDataSource {

    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체 퀘스트")
        case 1:
            return TMBarItem(title: "미완료 퀘스트")
        case 2:
            return TMBarItem(title: "완료 퀘스트")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }

    func numberOfViewControllers(
        in pageboyViewController: Pageboy.PageboyViewController) -> Int {
            return viewControllers.count
        }

    func viewController(
        for pageboyViewController: Pageboy.PageboyViewController,
        at index: Pageboy.PageboyViewController.PageIndex
    ) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(
        for pageboyViewController: Pageboy.PageboyViewController
    ) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}
