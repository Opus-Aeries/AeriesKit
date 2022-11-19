import Foundation

extension AeriesKit {
    public enum AeriesError: Error, LocalizedError {
        /// Couldn't reach the URL provided
        case couldNotConnect
        /// Returned when username/password was invalid
        case invalidLogin
        /// Error when creating the URL from ``AeriesKit/AeriesKit/baseUrl``
        case unableToMakeUrl
        /// Unknown Error
        case unknown

        public var errorDescription: String? {
            switch self {
            case .couldNotConnect:
                return NSLocalizedString("Could not connect to Aeries SIS.", comment: "Could Not Connect")
            case .invalidLogin:
                return NSLocalizedString("Unable to login, make sure email/password are correct.", comment: "Invalid Credentials")
            case .unableToMakeUrl:
                return nil
            case .unknown:
                return NSLocalizedString("An unknown error occurred.", comment: "Unknown Error")
            }
        }
    }

}
