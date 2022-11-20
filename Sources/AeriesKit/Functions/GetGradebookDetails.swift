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
            completion(.success(regex.returnFinalGradebook()))

        }.resume()
    }

    private struct AeriesRegexGradebook {

        let sourceText: String

        func makeSearch(_ start: String, _ end: String, type: String = ".") -> String {
            return "(?<=\(start))(\(type)*?)(?=\(end))"
        }

        let searchEnd = "</div>"

        func nameAndNumberSearch(_ segment: String) -> (Int, String) {
            let nameSearch = "<div class=\"TextHeading\">"
            let result = makeSearch(nameSearch, searchEnd).r!.findFirst(in: segment)!.matched

            let items = result.components(separatedBy: " - ")

            let number = Int(items[0])!
            let name = items[1]

            return (number, name)
        }

        let categorySearch = "<div class=\"TextSubSectionCategory\"><i class=\"fa fa-file-text-o\" title=\"Formative\" aria-hidden=\"true\"></i>"

        func scoreSearch(_ segment: String) -> AeriesScore? {
            let start = "<div class=\"FullWidth ScoreCard\">"

            let scoreBlockSearch = makeSearch(start, searchEnd, type: "[\\S\\s]")

            let result = scoreBlockSearch.r!.findFirst(in: sourceText)!

            let first: Int? = Int(makeSearch(
                "<span style='white-space:nowrap;'>",
                "</span>",
                type: "\\d"
            ).r?.findFirst(in: result.matched )?.matched ?? "")

            let last: Int? = Int(makeSearch(
                "<span style=';'>",
                "</span>",
                type: "\\d"
            ).r?.findFirst(in: result.matched )?.matched ?? "")

            if first != nil && last != nil {
                return AeriesScore(pointsReceived: first!, pointsPossible: last!)
            } else {
                return nil
            }
        }

        func correctSearch(_ segment: String) -> AeriesScore? {
            let start = "<div class=\"TextSubSection\">Complete</div>"

            let scoreBlockSearch = makeSearch(start, searchEnd, type: "[\\S\\s]")

            let result = scoreBlockSearch.r!.findFirst(in: sourceText)!

            let first: Int? = Int(makeSearch(
                "<span style=\"white-space:nowrap;\">",
                "</span>",
                type: "\\d"
            ).r?.findFirst(in: result.matched )?.matched ?? "")

            let last: Int? = Int(makeSearch(
                "<span style=';'>",
                "</span>",
                type: "\\d"
            ).r?.findFirst(in: result.matched )?.matched ?? "")

            if first != nil && last != nil {
                return AeriesScore(pointsReceived: first!, pointsPossible: last!)
            } else {
                return nil
            }
        }

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
            let nameNumber = nameAndNumberSearch(segment)
            number = nameNumber.0
            description = nameNumber.1

            // Find Category
            category = makeSearch(categorySearch, searchEnd).r?.findFirst(in: segment)?.matched ?? "unknown"

            // Find Score
            score = scoreSearch(segment)

            // Find Correct
            correct = correctSearch(segment)

            // Find Percent
            percent = makeSearch( percentSearch(number), "</span>").r?.findFirst(in: segment)?.matched

            // Find Comment
            category = makeSearch(commentSearch, searchEnd).r?.findFirst(in: segment)?.matched ?? ""

            // Find Date Completed
            dateCompleted = "(?<=<span class=\"TextSubSection\">Date Completed:</span> )[^\n\r]*".r?.findFirst(in: segment)?.matched

            // Find Date Due
            dueDate = "(?<=<span class=\"TextSubSection\" style=\"min-width: 90px;\">Due Date:</span> )[^\n\r]*".r?.findFirst(in: segment)?.matched

            // Find Grading Completed
            let grading = "(?<=<span class=\"TextSubSection\">Grading Complete:</span> )[^\n\r]*".r?.findFirst(in: segment)?.matched
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

        func returnFinalGradebook() -> [AeriesGradeBookEntry] {
            var finalGradebook: [AeriesGradeBookEntry] = []
            let segments = splitDataToSegments(sourceText)

            for segment in segments {
                if !segment.contains("tinymode FullWidth CardView") {

                    finalGradebook.append(segmentToGradebook(segment))
                }
            }

            return finalGradebook
        }
    }
}
