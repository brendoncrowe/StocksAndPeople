//
//  User.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import Foundation

struct UserResults: Decodable {
    let results: [User]
}

struct User: Decodable {
    let gender: String
    let name: Name
    let location: Location
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

extension UserResults {
    
    static func fetchUsers() -> [User] {
        var users = [User]()
        let data = Bundle.readRawJSONData(filename: "userinfo", ext: "json")
        
        do {
            let parsingResults = try JSONDecoder().decode(UserResults.self, from: data)
            users = parsingResults.results
        } catch {
            fatalError("There was an error \(error)")
        }
        return users
    }
}
