//
//  CategoryModel.swift
//  Next-Stap
//
//  Created by 김대희 on 2022/10/12.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

struct CategoryModel {
    let title: String
    let content: String
    let categoryString: String
    let categoryEnum: String
    let categoryImage: UIImage
    let categoryColor: UIColor
}

enum Category {
    case SPORT
    case STUDY
    case LIFE
    case HOBBY
    case BOOK
    case ENVIRONMENT
}

extension Category {
    func toQuestModel(_ title: String, _ content: String) -> CategoryModel {
        switch self {
        case .SPORT:
            return CategoryModel(
                title: title, content: content,
                categoryString: "운동", categoryEnum: "SPORT",
                categoryImage: NextStapAsset.Assets.small1.image,
                categoryColor: NextStapAsset.Color.mainColor.color)
        case .STUDY:
            return CategoryModel(
                title: title, content: content,
                categoryString: "공부", categoryEnum: "STUDY",
                categoryImage: NextStapAsset.Assets.small2.image,
                categoryColor: NextStapAsset.Color.subColor2.color)
        case .LIFE:
            return CategoryModel(
                title: title, content: content,
                categoryString: "생활페턴", categoryEnum: "LIFE",
                categoryImage: NextStapAsset.Assets.small3.image,
                categoryColor: NextStapAsset.Color.subColor1.color)
        case .HOBBY:
            return CategoryModel(
                title: title, content: content,
                categoryString: "취미", categoryEnum: "HOBBY",
                categoryImage: NextStapAsset.Assets.small4.image,
                categoryColor: NextStapAsset.Color.subColor3.color)
        case .BOOK:
            return CategoryModel(
                title: title, content: content,
                categoryString: "공부", categoryEnum: "BOOK",
                categoryImage: NextStapAsset.Assets.small5.image,
                categoryColor: NextStapAsset.Color.subColor4.color)
        case .ENVIRONMENT:
            return CategoryModel(
                title: title, content: content,
                categoryString: "환경", categoryEnum: "ENVIRONMENT",
                categoryImage: NextStapAsset.Assets.small6.image,
                categoryColor: NextStapAsset.Color.subColor5.color)
        }
    }
}
