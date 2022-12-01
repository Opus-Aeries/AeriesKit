import Foundation

public protocol AKData: Decodable, Hashable {}

/// Namespace entry for the library
public enum AeriesKit {
    public static func connection(configuration: AKConfiguration) -> AKConnection {
        return .init(configuration)
    }
}

#warning("Add Docs")
/// The interface for the actual Aeries mobile API
///
/// ## Making a Request
public struct AKConnection {
    let config: AKConfiguration


    init(_ config: AKConfiguration) {
        self.config = config
    }

    public func requestHomeScreenData(completion:@escaping(Result<AKLandingData,Error>) -> ()) async {
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

    func requestJsonData<T: Decodable>(
        endpoint: String,
        model: T.Type,
        extraPrint: Bool = false,
        completion:@escaping(Result<T,Error>) -> ()
    ) async {
        guard let url = URL(string: "\(config.baseUrl)Student/mobileapi/v1/\(endpoint)") else {
            completion(.failure(AeriesError.unableToMakeUrl))
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error { completion(.failure(error)) }
                return
            }

            if extraPrint {
                print(String(decoding: data, as: UTF8.self))
            }

            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(serverData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

/// The configuration for the AeriesKit instance
///
/// ## Topics
/// ### Related
/// - ``AKConnection``
public struct AKConfiguration {
    /// The base url of the Aeries portal.
    ///
    /// Base URLs must include a slash (`/`) at the end of them.
    ///
    /// ## Example:
    /// ```swift
    ///"https://demo.aeries.net/"
    /// ```
    public var baseUrl: String
    public var token: String
    public var studentId: String

    /// Create from data
    public init(baseUrl: String, token: String, studentId: String) {
        self.baseUrl = baseUrl
        self.token = token
        self.studentId = studentId
    }
}
