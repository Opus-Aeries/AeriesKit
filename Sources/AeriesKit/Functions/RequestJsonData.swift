import Foundation

extension AeriesKit {

    public func requestJsonData<T: Decodable>(
        endpoint: String,
        model: T.Type,
        extraPrint: Bool = false,
        completion:@escaping(Result<T,Error>) -> ()
    ) {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
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
