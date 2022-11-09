import Foundation
import ReactorKit
import UIKit
import Then

class AddRoutineReactor: Reactor {

    private let disposeBag: DisposeBag = .init()
    let initialState: State

    fileprivate let dFomatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }

    fileprivate let tFomatter = DateFormatter().then {
        $0.dateFormat = "HH : mm"
    }

    enum Action {
        case updateName(String)
        case updateStartTime(Date)
        case updateEndTime(Date)
        case updateTime(Date)
        case updateContent(String)
        case updateSchoolType(String)
        case nextButtonPress
    }
    enum Mutation {
        case setName(String)
        case setStartTime(Date)
        case setEndTime(Date)
        case setTime(Date)
        case setContent(String)
        case setSchoolType(String)
        case nextButtonClick
    }
    struct State {
        var name: String = ""
        var startTime: Date = Date()
        var endTime: Date = Date()
        var time: Date = Date()
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
            newState.isNavigate = true

            NextStapAPI.addQuest(req: AddQuestRequestDTO(
                title: newState.name,
                period: "\(dFomatter.string(from: newState.startTime))~\(dFomatter.string(from: newState.endTime))",
                time: "\(tFomatter.string(from: newState.time))",
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
