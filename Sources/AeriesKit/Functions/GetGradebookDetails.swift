import Foundation
import Regex
import RegexBuilder

extension AeriesKit {

    public func getGradebookDetails (
        url: String,
        extraPrint: Bool = false,
        useNewMethod: Bool = false,
        completion: @escaping (Result<[AeriesGradeBookEntry],Error>) -> ()
    ) {
        guard let url = URL(string: url) else {
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

            guard let dataString = String(data: data, encoding: .utf8) else {
                print("Unable to turn data into string!")
                return
            }

            if extraPrint {
                print(String(decoding: data, as: UTF8.self))
            }
            if useNewMethod {
                let regex = AeriesRegexGradebookNew(sourceText: dataString)
                Task {
                    await completion(.success(regex.returnFinalGradebook(extraPrint: extraPrint)))
                }
            } else {
                let regex = AeriesRegexGradebookOld(sourceText: dataString)
                Task {
                    await completion(.success(regex.returnFinalGradebook(extraPrint: extraPrint)))
                }
            }

        }.resume()
    }
}
