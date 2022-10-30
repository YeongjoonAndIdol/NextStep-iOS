import UIKit
import SnapKit
import Then

class AllQuestVC: UIViewController {
    private let titleLabel = UILabel().then {
        $0.textColor = NextStapAsset.Color.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(QuestListCell.self, forCellReuseIdentifier: "PostCell")
    }

    override func viewDidLoad() {

        [
            titleLabel,
            tableView
        ].forEach {
            view.addSubview($0)
        }
        titleLabel.text = "전체 퀘스트 | 6 개"

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

    }
}

extension AllQuestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return QuestListCell()
    }
}
