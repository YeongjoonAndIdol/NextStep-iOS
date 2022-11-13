import UIKit
import RxSwift
import SnapKit
import Then

class DetailQuestVC: UIViewController {

    typealias NextStapColor = NextStapAsset.Color
    typealias NextStapImage = NextStapAsset.Assets
    var disposeBag: DisposeBag = .init()
    var questArray: [CategoryModel] = [
        .init(title: "한강 공원 뛰기",
              content: "체지방이 줄고 근육량이 늘면서 체격이 좋아질 뿐만 아니라 바이러스로부터 견뎌낼 수 있는 방어 체력이 향상됩니다.",
              categoryString: "운동",
              categoryEnum: "",
              categoryImage: NextStapAsset.Assets.small1.image,
              categoryColor: NextStapAsset.Color.mainColor.color),
        .init(title: "수학 문제 풀기",
              content: "기본적으로 수학에 대한 지식이 풍부해지고, 모자란 창의성과 유연한 사고,다양성과 순발력을 키워주는 효과가 강합니다.",
              categoryString: "공부",
              categoryEnum: "",
              categoryImage: NextStapAsset.Assets.small5.image,
              categoryColor: NextStapAsset.Color.subColor4.color),
        .init(title: "일어나서 물 한잔 마시기",
              content: "아침에 일어나서 물을 마시게 된다면 머리도 빨리 돌아가고 과학적으로도 몸에 좋습니다. ",
              categoryString: "생활패턴",
              categoryEnum: "",
              categoryImage: NextStapAsset.Assets.small3.image,
              categoryColor: NextStapAsset.Color.subColor1.color),
        .init(title: "그림 그리기",
              content: "스트레스를 줄일 수 있다. 종이에 연필로 그림을 그리는 것은 자신을 옭아맨 생각에서 해방되는 기회를 만들어 줍니다.. ",
              categoryString: "취미",
              categoryEnum: "",
              categoryImage: NextStapAsset.Assets.small4.image,
              categoryColor: NextStapAsset.Color.subColor3.color)
    ]

    private let titleTextLabel = UILabel().then {
        $0.textColor = NextStapColor.mainColor.color
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }

    private let cancelButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = NextStapColor.mainColor.color
    }

    private let questTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(AddQuestListCell.self, forCellReuseIdentifier: "addQuestListCell")
    }

    private let doneBackView = UIView().then {
        $0.backgroundColor = NextStapColor.backGroundColor.color
    }

    private let doneButton = UIButton().then {
        $0.setTitleColor(NextStapColor.surfaceColor.color, for: .normal)
        $0.setTitle("루틴 사용하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = NextStapColor.mainColor.color
        $0.layer.cornerRadius = 10
    }

    private let heartButton = HeartButton()

    private let heartCountLabel = UILabel().then {
        $0.textColor = NextStapColor.onSurfaceColor.color
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .center
    }
    override func viewDidLoad() {
        addView()
        setLayout()
        configureVC()
    }
    func addView() {
        [
            titleTextLabel,
            cancelButton,
            questTableView,
            doneBackView,
            doneButton,
            heartButton,
            heartCountLabel
        ].forEach {
            view.addSubview($0)
        }
        questTableView.delegate = self
        questTableView.dataSource = self
        questTableView.reloadData()
    }
    func setLayout() {
        titleTextLabel.snp.makeConstraints {
            $0.left.equalTo(31)
            $0.top.equalTo(30)
            $0.height.equalTo(35)
        }
        cancelButton.snp.makeConstraints {
            $0.right.equalTo(-31)
            $0.top.equalTo(30)
            $0.width.height.equalTo(48)
        }
        doneBackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
        doneButton.snp.makeConstraints {
            $0.right.equalTo(-20)
            $0.height.equalTo(48)
            $0.left.equalTo(108)
            $0.top.equalTo(doneBackView.snp.top).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        questTableView.snp.makeConstraints {
            $0.top.equalTo(95)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(doneBackView.snp.bottom)
        }
        heartButton.snp.makeConstraints {
            $0.top.equalTo(doneBackView).offset(21)
            $0.left.equalTo(40)
            $0.width.height.equalTo(30)
        }
        heartCountLabel.snp.makeConstraints {
            $0.top.equalTo(heartButton.snp.bottom).offset(1)
            $0.centerX.equalTo(heartButton)
            $0.height.equalTo(19)
        }
    }
    func configureVC() {
        view.backgroundColor = NextStapColor.backGroundColor.color
        doneBackView.makeBackViewShadows()
        // dummy data
        titleTextLabel.text = "서울대생의 하루 루틴"
        heartCountLabel.text = "200"
    }
}
extension DetailQuestVC: UITableViewDelegate, UITableViewDataSource {
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
