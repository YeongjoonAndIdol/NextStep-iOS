import UIKit

class HomeVC: BaseVC<HomeReactor> {

    private let titleLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.text = "루틴/퀘스트"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    private let addButton = UIButton().then {
        $0.setImage(NextStapImage.addButtonIcon.image, for: .normal)
    }

    private let achievementButton = UIButton().then {
        $0.setImage(NextStapImage.trandButtonIcon.image, for: .normal)
    }

    private let questContainerView = UIView()
    private let questTabView = QuestTaBarView()

    private let goalTitleLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    private let goalProgressView = UIProgressView().then {
        $0.progressTintColor = NextStapColor.mainColor.color
        $0.trackTintColor = NextStapColor.gary4.color
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.layer.sublayers![1].cornerRadius = 6 // 뒤에 있는 회색 track
        $0.subviews[1].clipsToBounds = true
    }

    var paragraphStyle = NSMutableParagraphStyle().then {
        $0.lineHeightMultiple = 1.36
    }

    private let goalBottomLabel1 = UILabel()
    private let goalBottomLabel2 = UILabel()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func addView() {
        [
            titleLabel,
            addButton,
            achievementButton,
            questContainerView,
            goalTitleLabel,
            goalProgressView,
            goalBottomLabel1,
            goalBottomLabel2
        ].forEach {
            view.addSubview($0)
        }

        addChild(questTabView)
        view.addSubview(questTabView.view)
    }
    override func configureVC() {
        goalBottomLabel1.text = "0%"
        goalBottomLabel2.text = "100%"
        goalTitleLabel.text = "오늘 퀘스트\n0% 성공하셨습니다!"

        [goalBottomLabel1, goalBottomLabel2].forEach {
            $0.textColor = NextStapColor.mainColor.color
            $0.font = .systemFont(ofSize: 10, weight: .semibold)
        }
    }
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(40)
            $0.height.equalTo(35)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(21)
        }

        addButton.snp.makeConstraints {
            $0.right.equalTo(view).offset(-84)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel)
        }

        achievementButton.snp.makeConstraints {
            $0.right.equalTo(view).offset(-16)
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(titleLabel)
        }

        questTabView.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-195)
        }

        goalTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-120)
            $0.left.equalTo(40)
        }

        goalProgressView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.height.equalTo(12)
        }

        goalBottomLabel1.snp.makeConstraints {
            $0.leading.equalTo(goalProgressView.snp.leading)
            $0.top.equalTo(goalProgressView.snp.bottom).offset(4)
            $0.height.equalTo(18)
        }
        goalBottomLabel2.snp.makeConstraints {
            $0.trailing.equalTo(goalProgressView.snp.trailing)
            $0.top.equalTo(goalProgressView.snp.bottom).offset(4)
            $0.height.equalTo(18)
        }
    }

    override func bindView(reactor: HomeReactor) {
        addButton.rx.tap.bind {
            self.navigationController?.pushViewController(AddRoutineVC(reactor: AddRoutineReactor()), animated: true)
        }.disposed(by: disposeBag)

        if #available(iOS 15.0, *) {
            achievementButton.rx.tap
                .bind {
                    let selectSchoolVC = DetailQuestVC()
                    if let sheet = selectSchoolVC.sheetPresentationController {
                        sheet.detents = [.medium(), .large()]
                        sheet.prefersGrabberVisible = true
                        sheet.preferredCornerRadius = 32
                        self.present(selectSchoolVC, animated: true)
                    }
                }.disposed(by: disposeBag)
        }
    }

    override func bindAction(reactor: HomeReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func bindState(reactor: HomeReactor) {
        reactor.state
            .map { $0.progress }
            .bind { progress in
                self.setProgressView(progress: progress)
            }.disposed(by: disposeBag)
    }

    private func setProgressView(progress: Int) {
        goalTitleLabel.text = "오늘 퀘스트\n\(progress)% 성공하셨습니다!"

        let fullText = goalTitleLabel.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)

        let range = (fullText as NSString).range(of: "\(progress)%")
        let fullRange = (fullText as NSString).range(of: goalTitleLabel.text!)

        attribtuedString.addAttributes([NSAttributedString.Key.kern: -0.41,
                                        NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                       range: fullRange)
        attribtuedString.addAttribute(.foregroundColor,
                                        value: NextStapColor.mainColor.color,
                                        range: range)

        goalTitleLabel.attributedText = attribtuedString
        goalProgressView.setProgress(Float(Double(progress) * 0.01), animated: true)
    }
}
