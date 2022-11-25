import Foundation

/// Represents an assignment shown in ``AKLandingData``
public struct AKLandingAssignment: AKData {
    public var assignedDate: String
    public var assignmentName: String
    /// The assignment's unique number.
    ///
    /// Assignment numbers are unique to each gradebook and
    /// assignments are sorted by their numbers from lowest (first created)
    /// to highest (last created).
    public var assignmentNumber: Int
    public var categoryDescription: String
    /// The teacher's comment on the assignment
    ///
    /// If there is no comment the JSON will return
    /// a string with a whitespace character `" "`
    public var comment: String
    public var dueDate: String
    public var gradeBookName: String
    public var gradeBookNumber: Int
    public var gradingCompleted: Bool
    public var gradingCompletedDate: String
    public var isExtraCredit: Bool
    public var isMissing: Bool
    public var lastUpdated: String
    public var mark: String
    public var maxNumberCorrect: Double
    public var maxScore: Double
    public var numberCorrect: Double
    public var percentage: Double
    public var period: String
    public var periodTitle: String
    public var rubricAssignment: Bool
    public var schoolCode: Int
    public var score: Double
    public var status: String

    enum CodingKeys: String, CodingKey {
        case assignedDate = "AssignedDate"
        case assignmentName = "AssignmentName"
        case assignmentNumber = "AssignmentNumber"
        case categoryDescription = "CategoryDescription"
        case comment = "Comment"
        case dueDate = "DueDate"
        case gradeBookName = "GradebookName"
        case gradeBookNumber = "GradebookNumber"
        case gradingCompleted = "GradingCompleted"
        case gradingCompletedDate = "GradingCompletedDate"
        case isExtraCredit = "IsExtraCredit"
        case isMissing = "IsMissing"
        case lastUpdated = "LastUpdated"
        case mark = "Mark"
        case maxNumberCorrect = "MaxNumberCorrect"
        case maxScore = "MaxScore"
        case numberCorrect = "NumberCorrect"
        case percentage = "Percentage"
        case period = "Period"
        case periodTitle = "PeriodTitle"
        case rubricAssignment = "RubricAssignment"
        case schoolCode = "SchoolCode"
        case score = "Score"
        case status = "Status"
    }

    /// Create from data
    public init(
        assignedDate: String,
        assignmentName: String,
        assignmentNumber: Int,
        categoryDescription: String,
        comment: String,
        dueDate: String,
        gradeBookName: String,
        gradeBookNumber: Int,
        gradingCompleted: Bool,
        gradingCompletedDate: String,
        isExtraCredit: Bool,
        isMissing: Bool,
        lastUpdated: String,
        mark: String,
        maxNumberCorrect: Double,
        maxScore: Double,
        numberCorrect: Double,
        percentage: Double,
        period: String,
        periodTitle: String,
        rubricAssignment: Bool,
        schoolCode: Int,
        score: Double,
        status: String
    ) {
        self.assignedDate = assignedDate
        self.assignmentName = assignmentName
        self.assignmentNumber = assignmentNumber
        self.categoryDescription = categoryDescription
        self.comment = comment
        self.dueDate = dueDate
        self.gradeBookName = gradeBookName
        self.gradeBookNumber = gradeBookNumber
        self.gradingCompleted = gradingCompleted
        self.gradingCompletedDate = gradingCompletedDate
        self.isExtraCredit = isExtraCredit
        self.isMissing = isMissing
        self.lastUpdated = lastUpdated
        self.mark = mark
        self.maxNumberCorrect = maxNumberCorrect
        self.maxScore = maxScore
        self.numberCorrect = numberCorrect
        self.percentage = percentage
        self.period = period
        self.periodTitle = periodTitle
        self.rubricAssignment = rubricAssignment
        self.schoolCode = schoolCode
        self.score = score
        self.status = status
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assignedDate = try container.decode(String.self, forKey: .assignedDate)
        self.assignmentName = try container.decode(String.self, forKey: .assignmentName)
        self.assignmentNumber = try container.decode(Int.self, forKey: .assignmentNumber)
        self.categoryDescription = try container.decode(String.self, forKey: .categoryDescription)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.dueDate = try container.decode(String.self, forKey: .dueDate)
        self.gradeBookName = try container.decode(String.self, forKey: .gradeBookName)
        self.gradeBookNumber = try container.decode(Int.self, forKey: .gradeBookNumber)
        self.gradingCompleted = try container.decode(Bool.self, forKey: .gradingCompleted)
        self.gradingCompletedDate = try container.decode(String.self, forKey: .gradingCompletedDate)
        self.isExtraCredit = try container.decode(Bool.self, forKey: .isExtraCredit)
        self.isMissing = try container.decode(Bool.self, forKey: .isMissing)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated)
        self.mark = try container.decode(String.self, forKey: .mark)
        self.maxNumberCorrect = try container.decode(Double.self, forKey: .maxNumberCorrect)
        self.maxScore = try container.decode(Double.self, forKey: .maxScore)
        self.numberCorrect = try container.decode(Double.self, forKey: .numberCorrect)
        self.percentage = try container.decode(Double.self, forKey: .percentage)
        self.period = try container.decode(String.self, forKey: .period)
        self.periodTitle = try container.decode(String.self, forKey: .periodTitle)
        self.rubricAssignment = try container.decode(Bool.self, forKey: .rubricAssignment)
        self.schoolCode = try container.decode(Int.self, forKey: .schoolCode)
        self.score = try container.decode(Double.self, forKey: .score)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
