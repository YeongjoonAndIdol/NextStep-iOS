import UIKit
import SnapKit
import Then
import RxSwift
import Moya
import RxMoya

class CompleteQuestVC: UIViewController {
    fileprivate var questList: [SingleQuestDTO] = []
    private let provider = MoyaProvider<NextStapAPI>()
    private let disposeBag: DisposeBag = .init()

    private let titleLabel = UILabel().then {
        $0.textColor = NextStapAsset.Color.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(QuestListCell.self, forCellReuseIdentifier: "QuestListCell")
    }

    override func viewDidLoad() {
        [
            titleLabel,
            tableView
        ].forEach {
            view.addSubview($0)
        }
        titleLabel.text = "완료 퀘스트 | - 개"
        getSchoolList()
        tableView.delegate = self
        tableView.dataSource = self

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.left.equalTo(40)
            $0.height.equalTo(28)
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(76)
        }
    }
    private func getSchoolList() {
        provider.rx.request(.fetchQuestList(type: "COMPLETE"))
            .subscribe { event in
                switch event {
                case let .success(response):
                    if let data = try? JSONDecoder().decode(FetchQuestListResponseDTO.self, from: response.data) {
                        self.questList = data.quest
                        self.titleLabel.text = "완료 퀘스트 | \(data.quest.count) 개"
                        self.tableView.reloadData()
                    }
                case let .failure(error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
}

extension CompleteQuestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "QuestListCell") as? QuestListCell)!
        let content = questList[indexPath.row]

        cell.titleLabel.text = content.name
        cell.checkButton.isChecked = content.isCompleted
        cell.checkButton.rx.tap.bind {
            self.provider.rx.request(.questRecommendAndCancel(questID: content.id))
                .subscribe { event in
                    switch event {
                    case .success:
                        break
                    case let .failure(error):
                        print(error)
                    }
                }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        return cell
    }
}
