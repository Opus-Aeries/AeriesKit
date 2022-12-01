import Foundation

public extension AKConnection {
    /// Requests all assignments for a specific course gradebook
    /// - Parameters:
    ///   - schoolCode: The integer describing the school. Can be found as a property of ``AKLandingClassSchedule``
    ///   - gradebookNumber: The integer describing the specific gradebook to load. Can be found as a property of ``AKClassSummary``
    ///   - termCode: The string describing the specific term's gradebook to load. Can be found as a property of ``AKClassSummary``
    ///   - completion: Either returns an `Error` or ``AKGradebook``
    func requestGradebookDetails(
        schoolCode: Int,
        gradebookNumber: Int,
        termCode: String,
        completion: @escaping(Result<AKGradebook, Error>) -> ()
    ) async {
        await requestJsonData(
            endpoint: "\(schoolCode)/student/\(config.studentId)/gradebooks/\(gradebookNumber)/\(termCode)",
            model: AKGradebook.self
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
