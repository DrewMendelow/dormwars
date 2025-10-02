//
//  User.swift
//  DormWars
//
//  Created by Drew Mendelow on 9/27/25.
//
class User: Codable {
    var userId: Int64
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String?
    var school: School
    var userType: String
    
    init(userId: Int64, firstName: String, lastName: String, email: String, phoneNumber: String? = nil, school: School, userType: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.school = school
        self.userType = userType
    }

}
