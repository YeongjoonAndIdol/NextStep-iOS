import ReactorKit
import Moya

class AddQuestReactor: Reactor {

    private let disposeBag: DisposeBag = .init()
    let initialState: State

    enum Action {
        case updateName(String)
        case updatePeriod(String)
        case updateTime(String)
        case updateContent(String)
        case updateSchoolType(String)
        case nextButtonPress

    }
    enum Mutation {
        case setName(String)
        case setPeriod(String)
        case setTime(String)
        case setContent(String)
        case setSchoolType(String)
        case nextButtonClick
    }
    struct State {
        var name: String = ""
        var preiod: String = ""
        var time: String = ""
        var content: String = ""
        var schoolType: String = ""
        var isNavigate: Bool = false
    }

    init() {
        initialState = State()
    }
}

// MARK: - Mutate
extension AddQuestReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateName(name):
            return .just(.setName(name))
        case let .updatePeriod(period):
            return .just(.setPeriod(period))
        case let .updateTime(time):
            return .just(.setTime(time))
        case let .updateContent(content):
            return .just(.setContent(content))
        case let .updateSchoolType(schoolType):
            return .just(.setSchoolType(schoolType))
        case .nextButtonPress:
            return .just(.nextButtonClick)
        }
    }
}

// MARK: - Reduce
extension AddQuestReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setName(name):
            newState.name = name
        case let .setPeriod(period):
            newState.preiod = period
        case let .setTime(time):
            newState.time = time
        case let .setContent(content):
            newState.content = content
        case let .setSchoolType(schoolType):
            newState.schoolType = schoolType
        case .nextButtonClick:
            NextStapAPI.addQuest(req: AddQuestRequestDTO(
                title: newState.name,
                period: newState.preiod,
                time: newState.time,
                content: newState.content,
                schoolType: newState.schoolType
                )
            )
            .request()
            .subscribe { event in
                switch event {
                case .success:
                    newState.isNavigate = true
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        }
        return newState
    }
}
