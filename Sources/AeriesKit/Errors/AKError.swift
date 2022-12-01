import Foundation

public enum AKError: Error, LocalizedError {
    /// Couldn't reach the URL provided
    case couldNotConnect
    /// Returned when username/password was invalid
    case invalidLogin
    /// Error when creating the URL
    case unableToMakeUrl

    /// Unknown Error
    case unknown

    public var errorDescription: String? {
        switch self {
        case .couldNotConnect:
            return NSLocalizedString("Could not connect to Aeries SIS.", comment: "")
        case .invalidLogin:
            return NSLocalizedString("Make sure email/password are correct.", comment: "")
        case .unableToMakeUrl:
            return nil
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "")
        }
    }
}
