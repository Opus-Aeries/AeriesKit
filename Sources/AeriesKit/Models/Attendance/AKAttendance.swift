import Foundation

/// Represents the overview of an attendance call
public struct AKAttendance: AKData {
    /// The list of the user's classes
    public var details: [AKAttendanceDetail]
    /// The specific identifier for the user's school
    public var schoolCode: Int
    /// The name of the user's school
    public var schoolName: String
    /// The user's student id number.
    public var studentId: Int

    enum CodingKeys: String, CodingKey {
        case details = "AttendanceDetails"
        case schoolCode = "SchoolCode"
        case schoolName = "SchoolName"
        case studentId = "StudentID"
    }

    /// Create from data
    public init(
        details: [AKAttendanceDetail],
        schoolCode: Int,
        schoolName: String,
        studentId: Int
    ) {
        self.details = details
        self.schoolCode = schoolCode
        self.schoolName = schoolName
        self.studentId = studentId
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.details = try container.decode([AKAttendanceDetail].self, forKey: .details)
        self.schoolCode = try container.decode(Int.self, forKey: .schoolCode)
        self.schoolName = try container.decode(String.self, forKey: .schoolName)
        self.studentId = try container.decode(Int.self, forKey: .studentId)
    }
}

/// A single Aeries attendance item
public struct AKAttendanceDetail: AKData {
    public var attendanceDate: String

    public var allDayCode: String

    public var allDayDescription: String

    public var absenceType: Int

    public var attendancePeriod: [AKAttendancePeriod]

    public struct AKAttendancePeriod: AKData {
        public var period: Int
        public var periodTitle: String
        public var courseTitle: String
        public var code: String
        public var description: String
        public var absenceType: Int

        enum CodingKeys: String, CodingKey {
            case period = "Period"
            case periodTitle = "PeriodTitle"
            case courseTitle = "CourseTitle"
            case code = "Code"
            case description = "Description"
            case absenceType = "AbsenceType"
        }

        /// Create from Data
        public init(
            period: Int,
            periodTitle: String,
            courseTitle: String,
            code: String,
            description: String,
            absenceType: Int
        ) {
            self.period = period
            self.periodTitle = periodTitle
            self.courseTitle = courseTitle
            self.code = code
            self.description = description
            self.absenceType = absenceType
        }

        /// Decode from JSON
        public init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<AKAttendanceDetail.AKAttendancePeriod.CodingKeys> = try decoder.container(keyedBy: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.self)
            self.period = try container.decode(Int.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.period)
            self.periodTitle = try container.decode(String.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.periodTitle)
            self.courseTitle = try container.decode(String.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.courseTitle)
            self.code = try container.decode(String.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.code)
            self.description = try container.decode(String.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.description)
            self.absenceType = try container.decode(Int.self, forKey: AKAttendanceDetail.AKAttendancePeriod.CodingKeys.absenceType)
        }
    }

    enum CodingKeys: String, CodingKey {
        case attendanceDate = "AttendanceDate"
        case allDayCode = "AllDayCode"
        case allDayDescription = "AllDayDescription"
        case absenceType = "AbsenceType"
        case attendancePeriod = "AttendancePeriod"
    }

    /// Create from data
    public init(
        attendanceDate: String,
        allDayCode: String,
        allDayDescription: String,
        absenceType: Int,
        attendancePeriod: [AKAttendancePeriod]
    ) {
        self.attendanceDate = attendanceDate
        self.allDayCode = allDayCode
        self.allDayDescription = allDayDescription
        self.absenceType = absenceType
        self.attendancePeriod = attendancePeriod
    }

    /// Decode from JSON
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attendanceDate = try container.decode(String.self, forKey: .attendanceDate)
        self.allDayCode = try container.decode(String.self, forKey: .allDayCode)
        self.allDayDescription = try container.decode(String.self, forKey: .allDayDescription)
        self.absenceType = try container.decode(Int.self, forKey: .absenceType)
        self.attendancePeriod = try container.decode([AKAttendanceDetail.AKAttendancePeriod].self, forKey: .attendancePeriod)
    }
}

/*
 "SchoolCode": 116,
 "SchoolName": "SANTA MONICA HIGH SCHOOL",
 "StudentID": 128389,
 "StudentAttendanceType": 0,
 "StudentRedFlag": null,
 "AttendanceMessage": null,
 "AttendanceDetails": [
 */

