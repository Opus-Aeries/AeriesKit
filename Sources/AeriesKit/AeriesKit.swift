import Foundation

public struct AeriesKit {
    /// The base URL to the Aeries server
    public var baseUrl: String

    /// Whether the user has passed authentication
    public var loginStatus: AeriesLoginState = .loggedOut

    /// Determines the state of the user's login
    public enum AeriesLoginState {
        case loggedIn
        case loggedOut
    }

    /// Initialize AeriesKit
    /// - Parameter baseUrl: The base URL of the school/district
    public init(baseUrl: String) {
        if baseUrl.last == "/" {
            self.baseUrl = baseUrl
        } else {
            self.baseUrl = baseUrl+"/"
        }

    }
}
