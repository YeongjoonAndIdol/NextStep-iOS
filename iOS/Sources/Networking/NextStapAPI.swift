import Foundation
import Moya

enum NextStapAPI {
    // /users
    case signIn(req: SigninRequestDTO)
    case signUp(req: SIgnUpRequestDTO)

    // /quests
    case fetchQuestList(type: String)
    case fetchQuestDetail(questID: String)
    case addQuest(req: AddQuestRequestDTO)
    case addList(questID: String, req: AddListRequestDTO)
    case questRecommendAndCancel(questID: String)

    // /retrospects
    case writeRetrospects(req: WriteRetrospectsRequestDTO)
    case fetchRetrospects(date: String)
}

extension NextStapAPI: Moya.TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data { Data() }
    var task: Task { return getTask() }
    var headers: [String: String]? { return getHeader() }
}

extension NextStapAPI {

    func getBaseURL() -> URL {
        return URL(string: "https://github.com")!
    }

    func getPath() -> String {
        switch self {
        case .signIn:
            return "/users/signin"
        case .signUp:
            return "/users/signup"
        case .fetchQuestList:
            return "/quests/list"
        case let .fetchQuestDetail(questID):
            return "/quests/\(questID)"
        case .addQuest:
            return "/quests"
        case let .addList(_, questID):
            return "/quests/lists/\(questID)"
        case let .questRecommendAndCancel(questID):
            return "/quests/recommend/\(questID)"
        case .writeRetrospects:
            return "/retrospects"
        case .fetchRetrospects:
            return "/docs/template"
        }
    }

    func getMethod() -> Moya.Method {
        switch self {
        case .fetchQuestList, .fetchRetrospects, .fetchQuestDetail:
            return .get
        case .signIn, .signUp, .addList, .addQuest, .writeRetrospects:
            return .post
        case .questRecommendAndCancel:
            return .patch
        }
    }

    func getTask() -> Task {
        switch self {
        case let .signIn(req):
            return .requestJSONEncodable(req)

        case let .signUp(req):
            return .requestJSONEncodable(req)

        case let .fetchQuestList(type):
            return .requestParameters(
                parameters: ["type": type],
                encoding: URLEncoding.queryString
            )

        case let .addQuest(req):
            return .requestJSONEncodable(req)

        case let .addList(_, req):
            return .requestJSONEncodable(req)

        case let .writeRetrospects(req):
            return .requestJSONEncodable(req)

        case let .fetchRetrospects(date):
            return .requestParameters(
                parameters: ["date": date],
                encoding: URLEncoding.queryString
            )

        default:
            return .requestPlain
        }
    }

    func getHeader() -> [String: String] {
        switch self {
        case .signIn, .signUp:
            return ["Content-Type": "application/json"]
        default:
            return ["Authorization": "Bearer \(KeyChain.read(key: KeyChainDTO.accessToken) ?? "")"]
        }
    }
}
