import UIKit

protocol AddQuestDelegate: AnyObject {
    func dismissWriteQuestVC(_ questArray: [CategoryModel])
}

class AddQuestVC: BaseVC<AddQuestReactor> {
    var questID: String = ""
    var questArray: [CategoryModel] = []

    private let questTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(AddQuestListCell.self, forCellReuseIdentifier: "addQuestListCell")
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let addbarButton = UIBarButtonItem(
        title: "추가",
        style: .plain,
        target: AddQuestVC.self,
        action: nil)

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func addView() {
        [
            questTableView,
            doneButton
        ].forEach {
            view.addSubview($0)
        }

        questTableView.delegate = self
        questTableView.dataSource = self
        questTableView.reloadData()

    }

    override func setLayout() {
        questTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(-125)
        }

        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.height.equalTo(48)
        }
    }

    override func configureVC() {

        navigationItem.title = "퀘스트 생성"
        navigationItem.rightBarButtonItem = addbarButton

        if #available(iOS 16.0, *) {
            addbarButton.rx.tap.bind {
                let writeQuestVC = WriteQuestVC()
                writeQuestVC.questID = self.questID
                if let sheet = writeQuestVC.sheetPresentationController {
                    sheet.detents = [.custom { _ in
                        return 700
                    }]
                    sheet.prefersGrabberVisible = true
                    sheet.preferredCornerRadius = 32
                    writeQuestVC.delegate = self
                    writeQuestVC.questArray = self.questArray
                    self.present(writeQuestVC, animated: true)
                }
            }.disposed(by: disposeBag)
        }

        doneButton.rx.tap.bind {
            self.navigationController?.popToRootViewController(animated: true)
        }.disposed(by: disposeBag)

    }

}
extension AddQuestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(
            withIdentifier: "addQuestListCell") as? AddQuestListCell)!
        let content = questArray[indexPath.row]
        cell.categoryImage.image = content.categoryImage
        cell.categorytextLabel.text = content.categoryString
        cell.questTitleLabel.text = content.title
        cell.contentTextLabel.text = content.content
        cell.leftBar.backgroundColor = content.categoryColor
        return cell
    }
}

extension AddQuestVC: AddQuestDelegate {
    func dismissWriteQuestVC(_ questArray: [CategoryModel]) {
        self.questArray = questArray
        questTableView.reloadData()
    }
}
