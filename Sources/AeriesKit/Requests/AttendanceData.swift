import Foundation

public extension AKConnection {
    /// Requests the user's attendance records
    /// - Parameters:
    ///   - schoolCode: The integer describing the school. Can be found as a property of ``AKLandingClassSchedule``
    ///   - completion: Either returns an `Error` or ``[AKLandingData]``
    func requestAttendanceData(schoolCode: Int, completion:@escaping(Result<[AKAttendance],Error>) -> ()) async {
        await requestJsonData(
            endpoint: "\(schoolCode)/student/\(config.studentId)/schoolyearattendance/",
            model: [AKAttendance].self
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
