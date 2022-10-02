//
//  baseVC.swift
//  solvedAC
//
//  Created by baegteun on 2021/10/29.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class BaseVC<T: Reactor>: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets

    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()

    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NextStapColor.backGroundColor.color
        addView()
        setLayout()
        configureVC()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
    }

    init(reactor: T) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func addView() {}
    func setLayout() {}
    func configureVC() {}
    func bindView(reactor: T) {}
    func bindAction(reactor: T) {}
    func bindState(reactor: T) {}
}

extension BaseVC: View {
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
