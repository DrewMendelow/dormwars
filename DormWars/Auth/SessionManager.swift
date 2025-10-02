//
//  SessionManager.swift
//  DormWars
//
//  Created by Drew Mendelow on 10/1/25.
//

import Foundation
internal import Combine

// In ViewModels or Views access currentUser by using SessionManager.shared.currentUser

@MainActor
class SessionManager: ObservableObject {
    static let shared = SessionManager()

    @Published var currentUser: User?
    @Published var testTeam: Team?


    private init() {
        //Hardcode user until login and registration is created
        currentUser = User(userId: 1, firstName: "Drew", lastName: "Mendelow", email: "drew.mendelow@gmail.com", school: School(schoolId: 1, schoolName: "Georgia Tech", city: "Atlanta", state: "Georgia", primaryColor: "B3A369", secondaryColor: "003057", active: true), userType: "admin")
        

    }

    func updateUser(_ user: User?) {
        self.currentUser = user
    }

    func logout() {
        currentUser = nil
    }
}
