import Foundation

public extension AKConnection {
    /// Requests the data to be presented on the home screen
    /// - Parameter completion: Either returns an `Error` or ``AKLandingData``
    func requestHomeScreenData(completion:@escaping(Result<AKLandingData,Error>) -> ()) async {
        await requestJsonData(
            endpoint: "student/\(config.studentId)/homescreendata/",
            model: AKLandingData.self
        ) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

