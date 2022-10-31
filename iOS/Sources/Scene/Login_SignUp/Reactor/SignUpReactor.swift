import Foundation
import ReactorKit
import Moya
import RxMoya

class SignUpReactor: Reactor {
    private let disposeBag: DisposeBag = .init()
    private let provider = MoyaProvider<NextStapAPI>()
    let initialState: State

    enum Action {
        case updateID(String)
        case updatePassWord(String)
        case updateName(String)
        case signUpButtonPress
    }
    enum Mutation {
        case setID(String)
        case setPassWord(String)
        case setName(String)
        case signUp
    }
    struct State {
        var id: String = ""
        var passWord: String = ""
        var name: String = ""
        var isNavigate: Bool = false
    }

    init() {
        initialState = State()
    }

}

// MARK: - Mutate
extension SignUpReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateID(id):
            return .just(.setID(id))
        case let .updatePassWord(passWord):
            return .just(.setPassWord(passWord))
        case let .updateName(name):
            return .just(.setName(name))
        case .signUpButtonPress:
            return .just(.signUp)
        }
    }
}

// MARK: - Reduce
extension SignUpReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setID(id):
            newState.id = id
        case let .setPassWord(password):
            newState.passWord = password
        case let .setName(name):
            newState.name = name
        case .signUp:
            provider.rx.request(.signUp(req: .init(
                accountID: newState.id,
                password: newState.passWord,
                name: newState.name)))
            .subscribe { event in
                switch event {
                case let .success(response):
                    if response.statusCode == 200 {
                        newState.isNavigate = true
                    } else { print(response.statusCode) }
                case .failure:
                    print("Error")
                }
            }.disposed(by: disposeBag)
        }
        return newState
    }
}
