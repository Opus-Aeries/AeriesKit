import Foundation
import RegexBuilder

extension AeriesKit {
    /// Attempt to establish connection with Aeries server & authenticate user credentials
    /// - Parameters:
    ///   - email: The user's email to log in
    ///   - password: The user's password to log in
    public mutating func login(
        email: String,
        password: String,
        extraPrint: Bool = false,
        completion: @escaping (Result<[AeriesRecentData], Error>) -> ()
    ) {

        guard let url = URL(string: "\(baseUrl)Student/LoginParent.aspx") else {
            completion(.failure(AeriesError.unableToMakeUrl))
            return
        }

        var request = URLRequest(url: url)

        // Determine Paramaters
        let parameters = [
            [
                "key": "portalAccountUsername",
                "value": "\(email)",
                "type": "text"
            ],
            [
                "key": "portalAccountPassword",
                "value": "\(password)",
                "type": "text"
            ]
        ] as [[String : Any]]


        // Declare Boundary
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""

        // Set Boundary
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                if param["contentType"] != nil {
                    body += "\r\nContent-Type: \(param["contentType"] as! String)"
                }
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    let fileData = (try? NSData(contentsOfFile:paramSrc, options:[]) as Data)!
                    let fileContent = String(data: fileData, encoding: .utf8)!
                    body += "; filename=\"\(paramSrc)\"\r\n"
                    + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                }
            }
        }
        body += "--\(boundary)--\r\n";

        let postData = body.data(using: .utf8)

        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let data = data else {
                completion(.failure(AeriesError.couldNotConnect))
                return
            }

            guard let dataString = String(data: data, encoding: .utf8) else {
                print("Unable to turn data into string!")
                return
            }
            let jsonStringRef = Reference(Substring.self)

            let search = Regex {
                "var RecentData = "

                Capture(as: jsonStringRef) {
                    OneOrMore(.anyNonNewline)
                }
            }

            if let result = dataString.firstMatch(of: search) {
                var finalResult = result[jsonStringRef]

                if finalResult.hasSuffix(";") {
                    finalResult.removeLast()
                }

                if extraPrint {
                    print(finalResult)
                }

                do {
                    let serverData = try JSONDecoder().decode([AeriesRecentData].self, from: finalResult.data(using: .utf8) ?? Data())
                    completion(.success(serverData))
                } catch {
                    completion(.failure(error))
                }

            } else if dataString.contains("502 Bad Gateway"){
                completion(.failure(AeriesError.aeries502))
            }  else {
                completion(.failure(AeriesError.invalidLogin))
            }
        }
        task.resume()

    }

}
