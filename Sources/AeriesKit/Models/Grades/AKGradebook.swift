import Foundation

public struct AKGradebook: AKData {
    /// The identifier number for this gradebook
    public var gradebookNumber: Int
    /// The name of the gradebook
    public var gradebookName: String
    /// The term identifier code that a gradebook belongs to
    public var termCode: String
    /// The name of the term that a gradebook belongs to
    public var termDescription: String
    /// The status of this gradebook
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

    enum CodingKeys: String, CodingKey {
        case gradebookNumber = "GradebookNumber"
        case gradebookName = "GradebookName"
        case termCode = "TermCode"
        case termDescription = "TermDescription"
        case status = "Status"
        case period = "Period"
        case periodTitle = "PeriodTitle"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case categories = "Categories"
        case assignments = "Assignments"
    }

    /// Create from data
    public init(
        gradebookNumber: Int,
        gradebookName: String,
        termCode: String,
        termDescription: String,
        status: String,
        period: Int,
        periodTitle: String,
        startDate: String,
        endDate: String,
        categories: [AKAssignmentCategory],
        assignments: [AKAssignment]
    ) {
        self.gradebookNumber = gradebookNumber
        self.gradebookName = gradebookName
        self.termCode = termCode
        self.termDescription = termDescription
        self.status = status
        self.period = period
        self.periodTitle = periodTitle
        self.startDate = startDate
        self.endDate = endDate
        self.categories = categories
        self.assignments = assignments
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gradebookNumber = try container.decode(Int.self, forKey: .gradebookNumber)
        self.gradebookName = try container.decode(String.self, forKey: .gradebookName)
        self.termCode = try container.decode(String.self, forKey: .termCode)
        self.termDescription = try container.decode(String.self, forKey: .termDescription)
        self.status = try container.decode(String.self, forKey: .status)
        self.period = try container.decode(Int.self, forKey: .period)
        self.periodTitle = try container.decode(String.self, forKey: .periodTitle)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.categories = try container.decode([AKAssignmentCategory].self, forKey: .categories)
        self.assignments = try container.decode([AKAssignment].self, forKey: .assignments)
    }
}
