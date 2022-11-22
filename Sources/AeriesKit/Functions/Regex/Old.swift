//
// File.swift
// 
//
// Created by LeoSM_07 on 11/21/22.
//

import Foundation
import Regex

struct AeriesRegexGradebookOld {
    let sourceText: String
    let sourceTextCount: Int
    
    public init(sourceText: String) {
        self.sourceText = sourceText
        self.sourceTextCount = sourceText.count
    }
    
    let searchEnd = "</div>"
    
    let nameNumberRegex = try? NSRegularExpression(
        pattern: "(?<=<div class=\"TextHeading\">)(.*?)(?=</div>)",
        options: NSRegularExpression.Options.caseInsensitive
    )

    let categoryRegex = try? NSRegularExpression(
        pattern: "(?<=<div class=\"TextSubSectionCategory\"><i class=\"fa fa-file-text-o\" title=\"Formative\" aria-hidden=\"true\"></i>)(.*?)(?=</div>)",
        options: NSRegularExpression.Options.caseInsensitive
    )

    let commentRegex = try? NSRegularExpression(
        pattern: "(?<=<div style=\"max-height: 50px; overflow: auto;\">)(.*?)(?=</div>)",
        options: NSRegularExpression.Options.caseInsensitive
    )
    //
    //let dateCompletedRegex = try NSRegularExpression(
    //    pattern: "(?<=<span class=\"TextSubSection\">Date Completed:</span> )[^\n\r]*",
    //    options: NSRegularExpression.Options.caseInsensitive
    //)

    func makeSearchRevised(_ start: String, _ end: String, segment: Substring, length: Int? = nil, type: String = ".") -> String {
        do {
            let regex = try NSRegularExpression(
                pattern: "(?<=\(start))(\(type)*?)(?=\(end))",
                options: NSRegularExpression.Options.caseInsensitive
            )

            let matches = regex.matches(
                in: String(segment),
                options: [],
                range: NSRange(location: 0,
                length: length ?? segment.count)
            )

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

    func makeSearchRevisedCustom(_ regex: String, segment: Substring, length: Int? = nil, type: String = ".") -> String {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: String(segment), options: [], range: NSRange(location: 0, length: length ?? segment.count))

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

    func percentSearch(_ number: Int) -> String {
        var n = "\(number)"
        if number < 10 {
            n = "0"+n
        }

        return "<span id=\"ctl00_MainContent_subGBS_DataDetails_ctl\(n)_spTransfer\">"

    }

    let dateCompletedSearch = "<span class=\"TextSubSection\">Date Completed:</span> "


    func splitDataToSegments(_  data: String) -> [Substring] {

        return data.split(separator: "</tr>")
    }

    func segmentToGradebook(_ segment: Substring, extraPrint: Bool = false) -> AeriesGradeBookEntry {
        let segmentLength = segment.count
        var finalResult = AeriesGradeBookEntry(number: 999, description: "", category: "", gradingComplete: false)

        if extraPrint{ print(0) }

        // MARK: - Find Number and Description
        let matches = nameNumberRegex!.matches(
            in: String(segment),
            options: [],
            range: NSRange(location: 0, length: segmentLength)
        )
        if let match = matches.first {
            let range = match.range(at:1)
            if let swiftRange = Range(range, in: segment) {
                let name = segment[swiftRange]
                let items = name.components(separatedBy: " - ")
                finalResult.number = Int(items[0])!
                finalResult.description = items[1]
            }
        }

        // MARK: - Find Category
        if extraPrint{ print(1) }
        let matches1 = categoryRegex!.matches(
            in: String(segment),
            options: [],
            range: NSRange(location: 0, length: segmentLength)
        )
        if let match1 = matches.first {
            let range = match1.range(at:1)
            if let swiftRange = Range(range, in: segment) {
                finalResult.category = String(segment[swiftRange])
            }
        }

        // MARK: -  Find Score

        if extraPrint{ print(2) }
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
            finalResult.score = AeriesScore(pointsReceived: first1!, pointsPossible: last1!)
        }


        // MARK: - Find Correct

        if extraPrint{ print(3) }
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
            finalResult.correct = AeriesScore(pointsReceived: first2!, pointsPossible: last2!)
        }
        

        // MARK: - Find Percent
        if extraPrint{ print(4) }
        finalResult.percent = makeSearchRevised(
            percentSearch(finalResult.number),
            "</span>",
            segment: segment,
            length: segmentLength
        )

        // MARK: - Find Comment
        if extraPrint{ print(5) }
        let matches2 = commentRegex!.matches(
            in: String(segment),
            options: [],
            range: NSRange(location: 0, length: segmentLength)
        )
        if let match2 = matches2.first {
            let range = match2.range(at:1)
            if let swiftRange = Range(range, in: segment) {
                finalResult.comment = String(segment[swiftRange])
            }
        }

        // MARK: - Find Date Completed
        if extraPrint{ print(6) }
    //    let matches3 = dateCompletedRegex.matches(
    //        in: String(segment),
    //        options: [],
    //        range: NSRange(location: 0, length: segmentLength)
    //    )
    //    print("SD")
    //    if let match3 = matches3.first {
    //        let range = match3.range(at:1)
    //        print("SDD")
    //        if let swiftRange = Range(range, in: segment) {
    //            print("SDD")
    //            finalResult.dateCompleted = String(segment[swiftRange])
    //        }
    //    }
        finalResult.dateCompleted = makeSearchRevisedCustom(
            "(?<=<span class=\"TextSubSection\">Date Completed:</span> )[^\n\r]*", segment: segment, length: segmentLength
        )

        // MARK: - Find Date Due
        if extraPrint{ print(7) }
        finalResult.dueDate = makeSearchRevisedCustom(
            "(?<=<span class=\"TextSubSection\" style=\"min-width: 90px;\">Due Date:</span> )[^\n\r]*", segment: segment, length: segmentLength
        )

        // Find Grading Completed
        if extraPrint{ print(8) }
        let grading = makeSearchRevisedCustom(
            "(?<=<span class=\"TextSubSection\">Grading Complete:</span> )[^\n\r]*", segment: segment, length: segmentLength
        )
        if grading == "True" {
            finalResult.gradingComplete = true
        }

        return finalResult
    }

    func returnFinalGradebook(extraPrint: Bool) async -> [AeriesGradeBookEntry] {
        var finalGradebook: [AeriesGradeBookEntry] = []
        let segments = splitDataToSegments(sourceText)


        for segment in segments {
            if segment.contains("tinymode FullWidth CardView"){
                if extraPrint { print("\n\n\ngetting") }
                finalGradebook.append(segmentToGradebook(segment, extraPrint: extraPrint))
            }
        }

        return finalGradebook
    }
}
