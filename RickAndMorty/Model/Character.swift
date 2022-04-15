//
//  Character.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

struct Character: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
    let episode: [String]
}

struct Location: Codable {
    let name: String
    let url: String
}

