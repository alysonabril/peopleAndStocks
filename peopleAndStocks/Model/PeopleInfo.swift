//
//  People.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation

struct PeopleInfo: Codable {
    let results: [People]
    
    static func getPeople(from data: Data) throws-> [People] {
        do {
            let peopleInfo = try JSONDecoder().decode(PeopleInfo.self, from: data)
            return peopleInfo.results
        } catch let jsonError {
            throw appError.decodingError(jsonError)
        }
    }
}

struct People: Codable {
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let dob: String
    let picture: Picture
}

struct Name: Codable {
     let firstName: String
    private let lastName: String
    
    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
}

struct Location: Codable {
    private let street: String
    let city: String
    private let state: String
    private let postcode: String
    
    //computed property
    public var address: String {
        return "\(street) \n\(city.capitalized), \(state.capitalized) \(postcode)"
    }
}

struct Picture: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}
