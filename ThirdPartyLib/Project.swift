import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .RxFlow,
        .Realm,
        .Moya,
        .Then,
        .SnapKit,
        .DropDown,
        .Loaf,
        .Kingfisher,
        .ReactorKit
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.DropDown,
        .SPM.Loaf,
        .SPM.Kingfisher,
        .SPM.ReactorKit
    ]
)
