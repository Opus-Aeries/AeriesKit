import Foundation

/// A single entry for a single class's gradebook. Often comes as an array.
public struct AeriesGradeBookEntry: Hashable {
    /// The number of this assignment.
    /// Gradebook items are in order starting from 1
    public var number: Int
    /// The description of this item
    public var description: String
    /// The category this grade falls under
    public var category: String
    /// The score that this item received
    public var score: AeriesScore?
    /// The number of questions correct that this item received
    public var correct: AeriesScore?
    /// A string with the precent that the user got on this item.
    /// Can be calculated by dividing received points by possible points
    public var percent: String?
    /// The teacher's comment on this item
    public var comment: String?
    /// The date this item was completed.
    /// Comes in `MM/DD/YYYY` format
    public var dateCompleted: String?
    /// The date this item was due.
    /// Comes in `MM/DD/YYYY` format
    public var dueDate: String?
    /// A bool representing whether the grading for this assignment is complete
    public var gradingComplete: Bool

    public init(
        number: Int,
        description: String,
        category: String,
        score: AeriesScore? = nil,
        correct: AeriesScore? = nil,
        percent: String? = nil,
        comment: String? = nil,
        dateCompleted: String? = nil,
        dueDate: String? = nil,
        gradingComplete: Bool
    ) {
        self.number = number
        self.description = description
        self.category = category
        self.score = score
        self.correct = correct
        self.percent = percent
        self.comment = comment
        self.dateCompleted = dateCompleted
        self.dueDate = dueDate
        self.gradingComplete = gradingComplete
    }
}
