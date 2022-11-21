import Foundation

extension AeriesKit {
    public enum AeriesError: Error, LocalizedError {
        /// Couldn't reach the URL provided
        case couldNotConnect
        /// Returned when username/password was invalid
        case invalidLogin
        /// Error when creating the URL from ``AeriesKit/AeriesKit/baseUrl``
        case unableToMakeUrl
        /// Sometimes Aeries server decides to return a 503 error
        case aeries502
        /// Unable to decode a link to the gradebook for a ``AeriesClassSummary`` object
        case unableToDecodeGradebookLink

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
            case .aeries502:
                return NSLocalizedString("The Aeries server returned (502) Bad Gateway.", comment: "")
            case .unableToDecodeGradebookLink:
                return NSLocalizedString("Could not decode a link for this gradebook", comment: "")
            case .unknown:
                return NSLocalizedString("An unknown error occurred.", comment: "")
            }
        }
    }

}
