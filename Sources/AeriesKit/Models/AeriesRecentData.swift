import Foundation

public struct AeriesRecentData: Codable, Hashable {
    public var section: String

    public var STUSC: String

    public var STUSN: String

    public var title: String

    public var details: String

    public var DTS: String

    enum CodingKeys: String, CodingKey {
        case section = "Section"
        case STUSC
        case STUSN
        case title = "Title"
        case details = "Details"
        case DTS
    }

    public init(
        section: String,
        STUSC: String,
        STUSN: String,
        title: String,
        details: String,
        DTS: String
    ) {
        self.section = section
        self.STUSC = STUSC
        self.STUSN = STUSN
        self.title = title
        self.details = details
        self.DTS = DTS
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.section = try container.decode(String.self, forKey: .section)
        self.STUSC = try container.decode(String.self, forKey: .STUSC)
        self.STUSN = try container.decode(String.self, forKey: .STUSN)
        self.title = try container.decode(String.self, forKey: .title)
        self.details = try container.decode(String.self, forKey: .details)
        self.DTS = try container.decode(String.self, forKey: .DTS)
    }
}
