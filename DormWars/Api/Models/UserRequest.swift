//
//  UserRequest.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//
class UserRequest: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String?
    var schoolId: Int64
    var userType: String
    
    init(firstName: String, lastName: String, email: String,
         phoneNumber: String? = nil, schoolId: Int64, userType: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.schoolId = schoolId
        self.userType = userType
    }
}

