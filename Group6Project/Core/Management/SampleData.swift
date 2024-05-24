//
//  SampleData.swift
//  Group6Project
//
//  Created by Trung Hieu on 24/05/2024.
//

import Foundation

public struct UserTest {
    public var userName: String
    public var email: String
    public var accountType: String
    
    public init(userName: String, email: String, accountType: String) {
        self.userName = userName
        self.email = email
        self.accountType = accountType
    }
}

public var userList: [UserTest] = [
    UserTest(userName: "user1", email: "user1@example.com", accountType: "Manager"),
    UserTest(userName: "user2", email: "user2@example.com", accountType: "Staff"),
    UserTest(userName: "user3", email: "user3@example.com", accountType: "Manager"),
    UserTest(userName: "user4", email: "user4@example.com", accountType: "Staff"),
    UserTest(userName: "user5", email: "user5@example.com", accountType: "Staff"),
    UserTest(userName: "user6", email: "user6@example.com", accountType: "Staff"),
    UserTest(userName: "user7", email: "user7@example.com", accountType: "Staff"),
    UserTest(userName: "user8", email: "user8@example.com", accountType: "Staff"),
    UserTest(userName: "user9", email: "user9@example.com", accountType: "Staff"),
    UserTest(userName: "user10", email: "user10@example.com", accountType: "Staff")
]
