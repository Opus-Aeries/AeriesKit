import Foundation

/// General information about the user's schedule and classes
public struct AKLandingClassSchedule: AKData {
    /// The list of the user's classes
    public var classSummary: [AKClassSummary]
    /// The specific identifier for the user's school
    public var schoolCode: Int
    /// The name of the user's school
    public var schoolName: Bool
    /// If the app should show the current period
    public var showPeriod: Bool
    /// The user's student id number.
    public var studentId: Int

    enum CodingKeys: String, CodingKey {
        case classSummary = "ClassSummary"
        case schoolCode = "SchoolCode"
        case schoolName = "SchoolName"
        case showPeriod = "ShowPeriod"
        case studentId = "StudentID"
    }

    /// Create from data
    public init(
        classSummary: [AKClassSummary],
        schoolCode: Int,
        schoolName: Bool,
        showPeriod: Bool,
        studentId: Int
    ) {
        self.classSummary = classSummary
        self.schoolCode = schoolCode
        self.schoolName = schoolName
        self.showPeriod = showPeriod
        self.studentId = studentId
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.classSummary = try container.decode([AKClassSummary].self, forKey: .classSummary)
        self.schoolCode = try container.decode(Int.self, forKey: .schoolCode)
        self.schoolName = try container.decode(Bool.self, forKey: .schoolName)
        self.showPeriod = try container.decode(Bool.self, forKey: .showPeriod)
        self.studentId = try container.decode(Int.self, forKey: .studentId)
    }
}
