import Foundation
import ReactorKit
import Moya
import RxMoya

class HomeReactor: Reactor {
    private let disposeBag: DisposeBag = .init()
    private let provider = MoyaProvider<NextStapAPI>()
    let initialState: State

    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case fetchQuestList
    }
    struct State {
        var progress: Int = 0
    }

    init() {
        initialState = State()
    }

}

// MARK: - Mutate
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .just(.fetchQuestList)
        }
    }
}

// MARK: - Reduce
extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .fetchQuestList:
            NextStapAPI.fetchQuestList(type: "ALL").request()
            .subscribe { event in
                switch event {
                case let .success(response):
                    if let data = try? JSONDecoder().decode(FetchQuestListResponseDTO.self, from: response.data) {
                        newState.progress = data.progress
                    }
                case let .failure(error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        }
        return newState
    }
}
