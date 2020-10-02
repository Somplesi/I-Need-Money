//
//  APIResponse.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import Foundation

struct APIResponse: Decodable {
    var status: String
    var data: Datas
}

struct Datas: Decodable {
    var stats: Stats
    var coins: [Coin]
}

struct Stats: Decodable {
    var total: Int
    var offset: Int
    var limit: Int
    var order: String
    var base: String
}

struct Coin: Decodable {
    var id: Int
    var slug: String
    var symbol: String
    var name: String
    var description: String?
    var color: String?
    var iconType: String?
    var iconUrl: String?
    var websiteUrl: String?
    var type: String
    var volume: Int
    var price: String
    var change: Double
    var rank: Int
    
}
