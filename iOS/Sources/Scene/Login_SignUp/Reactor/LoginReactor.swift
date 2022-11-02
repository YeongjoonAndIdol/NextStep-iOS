import Foundation
import ReactorKit
import Moya
import RxMoya

class LoginReactor: Reactor {

    private let disposeBag: DisposeBag = .init()
    private let provider = MoyaProvider<NextStapAPI>()
    let initialState: State

    enum Action {
        case updateID(String)
        case updatePassWord(String)
        case loginButtonPress
    }
    enum Mutation {
        case setID(String)
        case setPassWord(String)
        case login
    }
    struct State {
        var id: String = ""
        var passWord: String = ""
        var isNavigate: Bool = false
    }

    init() {
        initialState = State()
    }

}
// MARK: - Mutate
extension LoginReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateID(id):
            return .just(.setID(id))
        case let .updatePassWord(password):
            return .just(.setPassWord(password))
        case .loginButtonPress:
            return .just(.login)
        }
    }
}

// MARK: - Reduce
extension LoginReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setID(id):
            newState.id = id
        case let .setPassWord(password):
            newState.passWord = password
        case .login:
            newState.isNavigate = true // dummy
            NextStapAPI.signIn(req: SigninRequestDTO(
                accountID: newState.id,
                password: newState.passWord))
            .request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    if let data = try? JSONDecoder().decode(TokenResponseDTO.self, from: response.data) {
                        KeyChain.create(key: KeyChainDTO.accessToken, token: data.accessToken)
                        KeyChain.create(key: KeyChainDTO.refreshToken, token: data.refreshToken)
                        newState.isNavigate = true
                    }
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        }
        return newState
    }
}
