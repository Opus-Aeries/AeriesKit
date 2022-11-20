import Foundation

/// Represents the score of an ``AeriesGradeBookEntry``
public struct AeriesScore: Hashable {
    /// The amount of points the user was given
    public var pointsReceived: Int
    /// The amount of points possible to receive
    public var pointsPossible: Int

    /// Create from data
    /// - Parameters:
    ///   - pointsReceived: The amount of points the user was given
    ///   - pointsPossible: The amount of points possible to receive
    public init(pointsReceived: Int, pointsPossible: Int) {
        self.pointsReceived = pointsReceived
        self.pointsPossible = pointsPossible
    }
}
