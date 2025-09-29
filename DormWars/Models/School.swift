//
//  School.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class School: Codable {
    var schoolId: Int64
    var schoolName: String
    var city: String?
    var state: String?
    var primaryColor: String?
    var secondaryColor: String?
    var schoolLogo: String?
    var active: Bool
    
    init(schoolId: Int64, schoolName: String, city: String? = nil, state: String? = nil, primaryColor: String? = nil, secondaryColor: String? = nil, schoolLogo: String? = nil, active: Bool) {
        self.schoolId = schoolId
        self.schoolName = schoolName
        self.city = city
        self.state = state
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.schoolLogo = schoolLogo
        self.active = active
    }
}
