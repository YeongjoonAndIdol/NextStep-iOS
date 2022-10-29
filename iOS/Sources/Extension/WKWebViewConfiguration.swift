import WebKit
import Foundation

extension WKWebViewConfiguration {
    static func includeCookie(cookies: [HTTPCookie], completion: @escaping (WKWebViewConfiguration?) -> Void) {
        let config = WKWebViewConfiguration()
        let dataStore = WKWebsiteDataStore.nonPersistent()

        DispatchQueue.main.async {
            let waitGroup = DispatchGroup()

            for cookie in cookies {
                waitGroup.enter()
                dataStore.httpCookieStore.setCookie(cookie) {
                    waitGroup.leave()
                }
            }

            waitGroup.notify(queue: DispatchQueue.main) {
                config.websiteDataStore = dataStore
                completion(config)
            }
        }
    }

}
