import Foundation

#warning("Finish Example Documentation")
/// The base assignment in any gradebook.
///
/// Each gradebook has several assignments and they should all be in order by number.
/// Assignments are sorted by ``number`` where `1` is the first assignment in the gradebook.
///
/// ### Matching Assignments to Categories
/// Each assignment should link to a ``AKAssignmentCategory`` via the ``category`` string.
/// You can map the categories to a list of strings and then see where the assignments match each category.
///
/// Example:
/// ```swift
///let categories: [AKAssignmentCategory]
///let assignments: [AKAssignment]
/// ```
public struct AKAssignment: AKData {
    /// The assignment's unique number.
    ///
    /// Assignment numbers are unique to each gradebook and
    /// assignments are sorted by their numbers from lowest (first created)
    /// to highest (last created).
    public var number: Int
    /// The name of the assignment
    public var name: String
    /// The Aeries type of assignment
    public var type: String
    /// The name of the category that this assignment belongs to
    public var category: String
    /// If the assignment has been graded yet
    public var isGraded: Bool
    /// If the assignment is extra credit
    public var isExtraCredit: Bool
    /// If the assignment is visible to parents
    public var isVisibleToParents: Bool
    /// The number of points the user got correct
    public var numberCorrect: Double
    /// The number of points possible to get correct
    public var numberPossible: Double
    /// A string form of the user's ``score``
    public var mark: String
    /// The number of points received for the assignment
    public var score: Double
    /// The maximum number of points possible to receive
    public var maxScore: Double
    /// The percent value of the score
    public var percent: Double
    /// The date the assignment was assigned
    public var dateAssigned: String
    /// The date the assignment was due
    public var dueDate: String
    /// The date the assignment grade was completed
    public var dateCompleted: String?
    /// The teacher's comment on the assignment
    ///
    /// If there is no comment the JSON will return
    /// a string with a whitespace character `" "`.
    public var comment: String
    /// The description of the assignment
    ///
    /// Can return an empty string `""`.
    public var description: String

    enum CodingKeys: String, CodingKey {
        case number = "AssignmentNumber"
        case name = "Description"
        case type = "Type"
        case category = "Category"
        case isGraded = "IsGraded"
        case isExtraCredit = "IsExtraCredit"
        case isVisibleToParents = "IsScoreVisibleToParents"
        case numberCorrect = "NumberCorrect"
        case numberPossible = "NumberPossible"
        case mark = "Mark"
        case score = "Score"
        case maxScore = "MaxScore"
        case percent = "Percent"
        case dateAssigned = "DateAssigned"
        case dueDate = "DateDue"
        case dateCompleted = "DateCompleted"
        case comment = "Comment"
        case description = "AssignmentDescription"
    }

    /// Create from data
    public init(
        number: Int,
        name: String,
        type: String,
        category: String,
        isGraded: Bool,
        isExtraCredit: Bool,
        isVisibleToParents: Bool,
        numberCorrect: Double,
        numberPossible: Double,
        mark: String,
        score: Double,
        maxScore: Double,
        percent: Double,
        dateAssigned: String,
        dueDate: String,
        dateCompleted: String? = nil,
        comment: String,
        description: String
    ) {
        self.number = number
        self.name = name
        self.type = type
        self.category = category
        self.isGraded = isGraded
        self.isExtraCredit = isExtraCredit
        self.isVisibleToParents = isVisibleToParents
        self.numberCorrect = numberCorrect
        self.numberPossible = numberPossible
        self.mark = mark
        self.score = score
        self.maxScore = maxScore
        self.percent = percent
        self.dateAssigned = dateAssigned
        self.dueDate = dueDate
        self.dateCompleted = dateCompleted
        self.comment = comment
        self.description = description
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.category = try container.decode(String.self, forKey: .category)
        self.isGraded = try container.decode(Bool.self, forKey: .isGraded)
        self.isExtraCredit = try container.decode(Bool.self, forKey: .isExtraCredit)
        self.isVisibleToParents = try container.decode(Bool.self, forKey: .isVisibleToParents)
        self.numberCorrect = try container.decode(Double.self, forKey: .numberCorrect)
        self.numberPossible = try container.decode(Double.self, forKey: .numberPossible)
        self.mark = try container.decode(String.self, forKey: .mark)
        self.score = try container.decode(Double.self, forKey: .score)
        self.maxScore = try container.decode(Double.self, forKey: .maxScore)
        self.percent = try container.decode(Double.self, forKey: .percent)
        self.dateAssigned = try container.decode(String.self, forKey: .dateAssigned)
        self.dueDate = try container.decode(String.self, forKey: .dueDate)
        self.dateCompleted = try container.decodeIfPresent(String.self, forKey: .dateCompleted)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
