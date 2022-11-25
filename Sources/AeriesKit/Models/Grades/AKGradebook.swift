import Foundation

public struct AKGradebook: AKData {
    ///
    public var gradebookNumber: Int
    ///
    public var gradebookName: String
    ///
    public var termCode: String
    ///
    public var termDescription: String
    ///
    public var status: String
    ///
    public var period: Int
    ///
    public var periodTitle: String
    ///
    public var startDate: String
    ///
    public var endDate: String

    public var categories: [AKAssignmentCategory]

    public var assignments: [AKAssignment]

    enum CodingKeys: CodingKey {
        case gradebookNumber
        case gradebookName
        case termCode
        case termDescription
        case status
        case period
        case periodTitle
        case startDate
        case endDate
        case categories
        case assignments
    }
}

/*
 "GradebookNumber": 5620689,
 "GradebookName": "AP English",
 "TermCode": "F",
 "TermDescription": "Fall",
 "Status": "Current",
 "Period": 5,
 "PeriodTitle": "5",
 "StartDate": "/Date(1660806000000)/",
 "EndDate": "/Date(1671177600000)/",
 "ShowWhatIf": true,
 "WhatIf": {
     "Hide": false,
     "Message": ""
 },
 "Categories": [],
 "Assignments": []
 */
