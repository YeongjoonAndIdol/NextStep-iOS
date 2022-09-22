import ProjectDescription

extension TargetDependency {
    public struct SPM {}
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxFlow = TargetDependency.package(product: "RxFlow")
    static let Realm = TargetDependency.package(product: "Realm")
    static let RealmSwift = TargetDependency.package(product: "RealmSwift")
    static let RxMoya = TargetDependency.package(product: "RxMoya")
    static let Then = TargetDependency.package(product: "Then")
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let DropDown = TargetDependency.package(product: "DropDown")
    static let Loaf = TargetDependency.package(product: "Loaf")
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
    static let ReactorKit = TargetDependency.package(product: "ReactorKit")
    static let TextFieldEffects = TargetDependency.package(product: "TextFieldEffects")
    static let Tabman = TargetDependency.package(product: "Tabman")
}

public extension Package {
    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.2.0")
    )
    static let RxFlow = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxFlow.git",
        requirement: .upToNextMajor(from: "2.10.0")
    )
    static let Realm = Package.remote(
        url: "https://github.com/realm/realm-cocoa.git",
        requirement: .upToNextMajor(from: "10.25.0")
    )
    static let Moya = Package.remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .upToNextMajor(from: "15.0.0")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then.git",
        requirement: .upToNextMajor(from: "2.7.0")
    )
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.0.1")
    )
    static let DropDown = Package.remote(
        url: "https://github.com/AssistoLab/DropDown",
        requirement: .branch("master")
    )
    static let Loaf = Package.remote(
        url: "https://github.com/schmidyy/Loaf.git",
        requirement: .upToNextMajor(from: "0.7.0")
    )
    static let Kingfisher = Package.remote(
        url: "https://github.com/onevcat/Kingfisher",
        requirement: .upToNextMajor(from: "7.2.4")
    )
    static let ReactorKit = Package.remote(
        url: "https://github.com/ReactorKit/ReactorKit.git",
        requirement: .upToNextMajor(from: "3.0.0")
    )
    static let TextFieldEffects = Package.remote(
        url: "https://github.com/raulriera/TextFieldEffects.git",
        requirement: .upToNextMajor(from: "1.7.0")
    )
    static let Tabman = Package.remote(
        url: "https://github.com/uias/Tabman.git",
        requirement: .upToNextMajor(from: "2.13.0")
    )
}
