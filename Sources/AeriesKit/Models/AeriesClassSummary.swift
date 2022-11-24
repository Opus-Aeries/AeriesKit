import Foundation

/// Represents the overview and general details of a class
public struct AeriesClassSummary: AeriesData {
    /// An identifier for the class used by the Aeries API
    public var period: Int
    /// The date on which the class started
    public var startTime: String
    /// The date on which the class will end/ended
    public var endTime: String
    /// The section number used by for the class
    public var sectionNumber: Int
    /// The number identifier of the gradebook
    public var gradebookNumber: Int
    /// The name of the gradebook
    public var gradebookName: String
    /// The presentable identifier of the course
    public var courseNumber: String
    /// The title of the course
    public var courseTitle: String
    /// The number identifier of the teacher
    public var teacherNumber: Int
    /// The name of the teacher
    public var teacherName: String
    /// The actual room of the course
    public var roomNumber: String
    /// The current grade the user has in the course.
    /// Can be just a letter (`A`) or a letter and sign (`B-`)
    public var currentMark: String
    /// The actual percent value the user has in the class
    public var percent: Double
    /// The number of missing assignments the user has
    public var missingAssignmentCount: Int
    /// The name of the current term
    public var term: String
    /// The code for the current term
    public var termCode: String
    /// The date the gradebook was last updated
    public var lastUpdated: String
    /// The name of the class's period
    public var periodTitle: String

    enum CodingKeys: String, CodingKey {
        case period = "Period"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case sectionNumber = "SectionNumber"
        case gradebookNumber = "GradeBookNumber"
        case gradebookName = "GradeBookName"
        case courseNumber = "CourseNumber"
        case courseTitle = "CourseTitle"
        case teacherNumber = "TeacherNumber"
        case teacherName = "TeacherName"
        case roomNumber = "RoomNumber"
        case currentMark = "CurrentMark"
        case percent = "Percent"
        case missingAssignmentCount = "MissingAssignment"
        case term = "Term"
        case termCode = "TermCode"
        case lastUpdated = "LastUpdated"
        case periodTitle = "PeriodTitle"
    }

    /// Create from data
    public init(
        period: Int,
        startTime: String,
        endTime: String,
        sectionNumber: Int,
        gradebookNumber: Int,
        gradebookName: String,
        courseNumber: String,
        courseTitle: String,
        teacherNumber: Int,
        teacherName: String,
        roomNumber: String,
        currentMark: String,
        percent: Double,
        missingAssignmentCount: Int,
        term: String,
        termCode: String,
        lastUpdated: String,
        periodTitle: String
    ) {
        self.period = period
        self.startTime = startTime
        self.endTime = endTime
        self.sectionNumber = sectionNumber
        self.gradebookNumber = gradebookNumber
        self.gradebookName = gradebookName
        self.courseNumber = courseNumber
        self.courseTitle = courseTitle
        self.teacherNumber = teacherNumber
        self.teacherName = teacherName
        self.roomNumber = roomNumber
        self.currentMark = currentMark
        self.percent = percent
        self.missingAssignmentCount = missingAssignmentCount
        self.term = term
        self.termCode = termCode
        self.lastUpdated = lastUpdated
        self.periodTitle = periodTitle
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.period = try container.decode(Int.self, forKey: .period)
        self.startTime = try container.decode(String.self, forKey: .startTime)
        self.endTime = try container.decode(String.self, forKey: .endTime)
        self.sectionNumber = try container.decode(Int.self, forKey: .sectionNumber)
        self.gradebookNumber = try container.decode(Int.self, forKey: .gradebookNumber)
        self.gradebookName = try container.decode(String.self, forKey: .gradebookName)
        self.courseNumber = try container.decode(String.self, forKey: .courseNumber)
        self.courseTitle = try container.decode(String.self, forKey: .courseTitle)
        self.teacherNumber = try container.decode(Int.self, forKey: .teacherNumber)
        self.teacherName = try container.decode(String.self, forKey: .teacherName)
        self.roomNumber = try container.decode(String.self, forKey: .roomNumber)
        self.currentMark = try container.decode(String.self, forKey: .currentMark)
        self.percent = try container.decode(Double.self, forKey: .percent)
        self.missingAssignmentCount = try container.decode(Int.self, forKey: .missingAssignmentCount)
        self.term = try container.decode(String.self, forKey: .term)
        self.termCode = try container.decode(String.self, forKey: .termCode)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.periodTitle = try container.decode(String.self, forKey: .periodTitle)
    }

}
