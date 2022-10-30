//
//  TabBarVC.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/09/22.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tabOne = BaseNC(rootViewController: HomeVC(reactor: HomeReactor()))
        let tabOneBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            tag: 1)

        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = RankVC(reactor: RankReactor())
        let tabTwoBarItem2 = UITabBarItem(
            title: "순위",
            image: NextStapAsset.Assets.rankIcon.image,
            tag: 2)

        tabTwo.tabBarItem = tabTwoBarItem2

        let tabThr = BaseNC(rootViewController: SuggestVC(reactor: SuggestReactor()))
        let tabThrBarItem3 = UITabBarItem(
            title: "추천",
            image: NextStapAsset.Assets.suggestIcon.image,
            tag: 3)

        tabThr.tabBarItem = tabThrBarItem3

        let tabFou = BaseNC(rootViewController: MyPageVC(reactor: MyPageReactor()))
        let tabFouBarItem4 = UITabBarItem(
            title: "마이페이지",
            image: UIImage(systemName: "person.crop.circle.fill"),
            tag: 4)

        tabFou.tabBarItem = tabFouBarItem4

        self.tabBar.tintColor = NextStapAsset.Color.mainColor.color
        self.tabBar.unselectedItemTintColor = NextStapAsset.Color.textButtonDisabledColor.color

        self.viewControllers = [tabOne, tabTwo, tabThr, tabFou]
    }

}
