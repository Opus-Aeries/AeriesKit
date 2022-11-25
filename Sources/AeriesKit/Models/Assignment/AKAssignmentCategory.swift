import Foundation

/// An overall category that several gradebook assignments will belong to.
///
/// This object only contains information about the category and does not include
/// the assignments that are included in it.
public struct AKAssignmentCategory: AKData {
    /// The name of this category
    public var name: Int
    /// The number of assignments that belong to this category
    public var numberOfAssignments: Int
    /// The letter grade that the user has in the category.
    /// 
    /// Can be just a letter (`A`) or a letter and sign (`B-`)
    public var mark: String
    /// The number of points earned in the category
    public var pointsEarned: Int
    /// The number of points possible in the category
    public var pointsPossible: Int
    /// The user's percentage in the category
    public var percent: Double

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case numberOfAssignments = "NumberOfAssignment"
        case mark = "Mark"
        case pointsEarned = "PointsEarned"
        case pointsPossible = "PointsPossible"
        case percent = "Percent"
    }

    /// Create from data
    public init(
        name: Int,
        numberOfAssignments: Int,
        mark: String,
        pointsEarned: Int,
        pointsPossible: Int,
        percent: Double
    ) {
        self.name = name
        self.numberOfAssignments = numberOfAssignments
        self.mark = mark
        self.pointsEarned = pointsEarned
        self.pointsPossible = pointsPossible
        self.percent = percent
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(Int.self, forKey: .name)
        self.numberOfAssignments = try container.decode(Int.self, forKey: .numberOfAssignments)
        self.mark = try container.decode(String.self, forKey: .mark)
        self.pointsEarned = try container.decode(Int.self, forKey: .pointsEarned)
        self.pointsPossible = try container.decode(Int.self, forKey: .pointsPossible)
        self.percent = try container.decode(Double.self, forKey: .percent)
    }
}
