import Foundation

/// Relevant information that should be loaded when the user first authenticates/opens the app.
///
/// This data should not be loaded before the user signs in/authenticates. Generally it can be used for showing home screen items or a class schedule to then present the option for more gradebook detail.
public struct AKLandingData: AKData {
    /// A list of assignments that were recently updated/or graded for the first time
    public var recentChanges: [AKLandingAssignment]
    /// A list of assignments that are not graded yet but are still entered into the gradebook
    public var upcomingAssignments: [AKLandingAssignment]
    /// A list of class summary items. This contains preliminary data for showing a schedule or gradebook details
    public var classSummaryData: AKLandingClassSchedule
    /// The status message that the server returned. If there are no errors it will be `"success"`
    public var status: String

    enum CodingKeys: String, CodingKey {
        case recentChanges = "RecentChanges"
        case upcomingAssignments = "Assignments"
        case classSummaryData = "ClassSummaryData"
        case status = "status"
    }

    /// Create from data
    public init(
        recentChanges: [AKLandingAssignment],
        upcomingAssignments: [AKLandingAssignment],
        classSummaryData: AKLandingClassSchedule,
        status: String
    ) {
        self.recentChanges = recentChanges
        self.upcomingAssignments = upcomingAssignments
        self.classSummaryData = classSummaryData
        self.status = status
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recentChanges = try container.decode([AKLandingAssignment].self, forKey: .recentChanges)
        self.upcomingAssignments = try container.decode([AKLandingAssignment].self, forKey: .upcomingAssignments)
        self.classSummaryData = try container.decode(AKLandingClassSchedule.self, forKey: .classSummaryData)
        self.status = try container.decode(String.self, forKey: .status)
    }

}


