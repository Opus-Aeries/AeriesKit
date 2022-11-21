import Foundation
import Regex

extension AeriesKit {

    public func getGradebookDetails (
        url: String,
        extraPrint: Bool = false,
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

            let regex = AeriesRegexGradebook(sourceText: dataString)
            Task {
                await completion(.success(regex.returnFinalGradebook()))
            }

        }.resume()
    }

    private struct AeriesRegexGradebook {

        let sourceText: String
        let sourceTextCount: Int

        public init(sourceText: String) {
            self.sourceText = sourceText
            self.sourceTextCount = sourceText.count
        }

        func makeSearch(_ start: String, _ end: String, type: String = ".") -> String {
            return "(?<=\(start))(\(type)*?)(?=\(end))"
        }

        func makeSearchRevised(_ start: String, _ end: String, segment: String, length: Int? = nil, type: String = ".") -> String {
            do {
                let regex = try NSRegularExpression(pattern: "(?<=\(start))(\(type)*?)(?=\(end))", options: NSRegularExpression.Options.caseInsensitive)
                let matches = regex.matches(in: segment, options: [], range: NSRange(location: 0, length: length ?? segment.count))

                if let match = matches.first {
                    let range = match.range(at:1)
                    if let swiftRange = Range(range, in: segment) {
                        let name = segment[swiftRange]
                        return String(name)
                    }
                }
            } catch {
                print(error)
            }
            return ""
        }

        func makeSearchRevisedCustom(_ regex: String, segment: String, length: Int? = nil, type: String = ".") -> String {
            do {
                let regex = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
                let matches = regex.matches(in: segment, options: [], range: NSRange(location: 0, length: length ?? segment.count))

                if let match = matches.first {
                    let range = match.range(at:0)
                    if let swiftRange = Range(range, in: segment) {
                        let name = segment[swiftRange]
                        return String(name)
                    }
                }
            } catch {
                print(error)
            }
            return ""
        }

        let searchEnd = "</div>"

        let categorySearch = "<div class=\"TextSubSectionCategory\"><i class=\"fa fa-file-text-o\" title=\"Formative\" aria-hidden=\"true\"></i>"

        func percentSearch(_ number: Int) -> String {
            var n = "\(number)"
            if number < 10 {
                n = "0"+n
            }
            return "<span id=\"ctl00_MainContent_subGBS_DataDetails_ctl\(n)_spTransfer\">"
        }

        let commentSearch = "<div style=\"max-height: 50px; overflow: auto;\">"

        let dateCompletedSearch = "<span class=\"TextSubSection\">Date Completed:</span> "


        func splitDataToSegments(_  data: String) -> [String] {
            return data.split(using: "(</tr>)".r!)
        }

        func segmentToGradebook(_ segment: String) -> AeriesGradeBookEntry {
            let segmentLength = segment.count
            var number = 99999
            var description = ""
            var category = ""
            var score: AeriesScore? = nil
            var correct: AeriesScore? = nil
            var percent: String? = nil
            var comment: String? = nil
            var dateCompleted: String? = nil
            var dueDate: String? = nil
            var gradingComplete = false

            // Find Number and Description
            let nameSearch = "<div class=\"TextHeading\">"
            let result = makeSearchRevised(nameSearch, searchEnd, segment: segment, length: segmentLength)
            print(result)
            let items = result.components(separatedBy: " - ")

            number = Int(items[0])!
            description = items[1]
            print(0)

            // Find Category
            print(1)
            category = makeSearchRevised(categorySearch, searchEnd, segment: segment, length: segmentLength)


            // Find Score
            print(2)
            let first1: Int? = Int(makeSearchRevised(
                "<span style='white-space:nowrap;'>",
                "</span>",
                segment: segment,
                length: segmentLength,
                type: "\\d"
            ))

            let last1: Int? = Int(makeSearchRevised(
                "<span style=';'>",
                "</span>",
                segment: segment,
                length: segmentLength,
                type: "\\d"
            ))

            if first1 != nil && last1 != nil {
                score = AeriesScore(pointsReceived: first1!, pointsPossible: last1!)
            }


            // Find Correct
            print(3)
            let first2: Int? = Int(makeSearchRevised(
                "<span style=\"white-space:nowrap;\">",
                "</span>",
                segment: segment,
                length: segmentLength,
                type: "\\d"

            ))

            let last2: Int? = Int(makeSearchRevised(
                "<span style=';'>",
                "</span>",
                segment: segment,
                length: segmentLength,
                type: "\\d"
            ))

            if first2 != nil && last2 != nil {
                correct = AeriesScore(pointsReceived: first2!, pointsPossible: last2!)
            }



            // Find Percent
            print(4)
            percent = makeSearchRevised( percentSearch(number), "</span>", segment: segment, length: segmentLength)

            // Find Comment
            print(5)
            comment = makeSearchRevised(commentSearch, searchEnd, segment: segment, length: segmentLength)

            // Find Date Completed
            print(6)
            dateCompleted = makeSearchRevisedCustom(
                "(?<=<span class=\"TextSubSection\">Date Completed:</span> )[^\n\r]*", segment: segment, length: segmentLength
            )

            // Find Date Due
            print(7)
            dueDate = makeSearchRevisedCustom(
                "(?<=<span class=\"TextSubSection\" style=\"min-width: 90px;\">Due Date:</span> )[^\n\r]*", segment: segment, length: segmentLength
            )
            // Find Grading Completed
            print(8)
            let grading = makeSearchRevisedCustom(
                "(?<=<span class=\"TextSubSection\">Grading Complete:</span> )[^\n\r]*", segment: segment, length: segmentLength
            )
            if grading == "True" {
                gradingComplete = true
            }

            return AeriesGradeBookEntry(
                number: number,
                description: description,
                category: category,
                score: score,
                correct: correct,
                percent: percent,
                comment: comment,
                dateCompleted: dateCompleted,
                dueDate: dueDate,
                gradingComplete: gradingComplete
            )
        }

        func returnFinalGradebook() async -> [AeriesGradeBookEntry] {
            var finalGradebook: [AeriesGradeBookEntry] = []
            let segments = splitDataToSegments(sourceText)


            for segment in segments {
                if segment.contains("tinymode FullWidth CardView")
                    && segment.contains("<div class=\"TextSubSectionCategory\"><i class=\"fa fa-file-text-o\" title=\"Formative\" aria-hidden=\"true\"></i>"){
                    print("\n\n\ngetting")
                    finalGradebook.append(segmentToGradebook(segment))
                }
            }

            return finalGradebook
        }
    }
}
