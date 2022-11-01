import Foundation
import ReactorKit

class AddRoutineReactor: Reactor {

    private let disposeBag: DisposeBag = .init()
    let initialState: State

    enum Action {
        case updateName(String)
        case updateStartTime(String)
        case updateEndTime(String)
        case updateTime(String)
        case updateContent(String)
        case updateSchoolType(String)
        case nextButtonPress
    }
    enum Mutation {
        case setName(String)
        case setStartTime(String)
        case setEndTime(String)
        case setTime(String)
        case setContent(String)
        case setSchoolType(String)
        case nextButtonClick
    }
    struct State {
        var name: String = ""
        var startTime: String = ""
        var endTime: String = ""
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
extension AddRoutineReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateName(name):
            return .just(.setName(name))
        case let .updateStartTime(startTime):
            return .just(.setStartTime(startTime))
        case let .updateEndTime(endTime):
            return .just(.setEndTime(endTime))
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
extension AddRoutineReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setName(name):
            newState.name = name
        case let .setStartTime(startTime):
            newState.startTime = startTime
        case let .setEndTime(endTime):
            newState.endTime = endTime
        case let .setTime(time):
            newState.time = time
        case let .setContent(content):
            newState.content = content
        case let .setSchoolType(schoolType):
            newState.schoolType = schoolType
        case .nextButtonClick:
            NextStapAPI.addQuest(req: AddQuestRequestDTO(
                title: newState.name,
                period: "\(newState.startTime)~\(newState.endTime)",
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
