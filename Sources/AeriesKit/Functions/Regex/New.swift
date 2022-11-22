import Foundation
import RegexBuilder

struct AeriesRegexGradebookNew {
    let sourceText: String

    let numberRef = Reference(Int.self)
    let descriptionRef = Reference(Substring.self)
    let categoryRef = Reference(Substring.self)
    let score1Ref = Reference(Substring.self)
    let score2Ref = Reference(Substring.self)
    let correct1Ref = Reference(Substring.self)
    let correct2Ref = Reference(Substring.self)
    let percentRef = Reference(Substring.self)
    let commentRef = Reference(Substring.self)
    let dateCompletedRef = Reference(Substring.self)
    let dueDateRef = Reference(Substring.self)

    func segmentToGradebook(_ segment: Substring) -> AeriesGradeBookEntry? {


        let search = Regex{
            ZeroOrMore(.any)

            "<div class=\"TextHeading\">"
            TryCapture(as: numberRef) { OneOrMore(.digit) } transform: { Int($0) }
            " - "

            Capture(as: descriptionRef) { OneOrMore(.anyNonNewline) }
            "</div>"

            ZeroOrMore(.any)

            "<div class=\"TextSubSectionCategory\"><i class=\"fa fa-file-text\" title=\"Summative\" aria-hidden=\"true\"></i> "
            Capture(as: categoryRef) { OneOrMore(.anyNonNewline) }
            "</div>"

            ZeroOrMore(.any)


            "<div style=\"max-height: 50px; overflow: auto;\">"
            Capture(as: commentRef) {
                Optionally { OneOrMore(.anyNonNewline) }
            }
            "</div>"

            ZeroOrMore(.any)

            "<span class=\"TextSubSection\">Date Completed:</span> "
            Capture(as: dateCompletedRef) { OneOrMore(.anyNonNewline) }

            ZeroOrMore(.any)

            "<span class=\"TextSubSection\" style=\"min-width: 90px;\">Due Date:</span> "
            Capture(as: dueDateRef) { OneOrMore(.anyNonNewline) }

        }

        if let result = segment.firstMatch(of: search) {
            return AeriesGradeBookEntry(
                number: result[numberRef],
                description: String(result[descriptionRef]),
                category: String(result[categoryRef]),
                score: nil,
                correct: nil,
                percent: nil,
                comment: String(result[commentRef]),
                dateCompleted: String(result[dateCompletedRef]),
                dueDate: String(result[dueDateRef]),
                gradingComplete: false
            )
        } else {
            print("Couldn't return")
            return nil
        }


    }

    func returnFinalGradebook(extraPrint: Bool) async -> [AeriesGradeBookEntry] {
        var finalGradebook: [AeriesGradeBookEntry] = []
        let segments = sourceText.split(separator: "</tr>", omittingEmptySubsequences: true)


        for segment in segments {
            if segment.contains("tinymode FullWidth CardView"){
                if extraPrint {
                    print(segment)
                    print("\n\n\ngetting \(String(describing: segment.last))")
                }
                if let final = segmentToGradebook(segment) {
                    finalGradebook.append(final)
                }

            }
        }

        return finalGradebook
    }
}
