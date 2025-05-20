//
//  Review.swift
//  Musafirly
//
//  Created by Anthony on 4/8/25.
//


struct Review: Identifiable, Codable {
    var id: String { reviewerId }
    let reviewerId: String
    let name: String
    var profilePicture: String
    let rating: Int
    var description: String
    var images: [String]?
    let when: String
    var age: String?
}
