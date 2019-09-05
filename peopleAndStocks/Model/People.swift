//
//  People.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation

struct People: Codable {
    let results: [PersonInfo]
}

struct PersonInfo: Codable {
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let dob: String
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
    
    public var fullName: String {
        return "\(first.capitalized) \(last.capitalized)"
    }
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
    
    public var address: String {
        return "\(street) \n\(city.capitalized), \(state.capitalized) \(postcode)"
    }
}

struct Picture: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}
