//
//  APIResponse.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import Foundation

/* https://docs.coinranking.com/#coins
 Response:

 HTTP/1.1 200 OK
 {
   "status": "success",
   "data": {
     "stats": {
       "total": 3217,
       "offset": 0,
       "limit": 50,
       "order": "desc",
       "base": "USD"
     },
     "coins": [
       {
         "id": 1,
         "slug": "bitcoin-btc",
         "symbol": "BTC",
         "name": "Bitcoin",
         "description": "Bitcoin is the first decentralized digital currency.",
         "color": "#f7931A",
         "iconType": "vector",
         "iconUrl": "https://cdn.coinranking.com/Sy33Krudb/btc.svg",
         "websiteUrl": "https://bitcoin.org",
         "socials": [
           {
             "name": "Bitcoin",
             "url": "https://www.reddit.com/r/Bitcoin/",
             "type": "reddit"
           }
         ],
         "confirmedSupply": true,
         "type": "coin",
         "volume": 6818750000,
         "marketCap": 159393904304,
         "price": "9370.9993109108",
         "circulatingSupply": 17009275,
         "totalSupply": 21000000,
         "firstSeen": 1330214400000,
         "change": -0.52,
         "rank": 1,
         "numberOfMarkets": 9800,
         "numberOfExchanges": 190,
         "history": [
           "9515.0454185372",
           "9540.1812284677",
           "9554.2212643043",
           "9593.571539283",
           "9592.8596962985",
           "9562.5310295967",
           "9556.7860427046",
           "9388.823394515",
           "9335.3004209165",
           "9329.4331700521",
           "9370.9993109108"
         ],
         "allTimeHigh": {
           "price": "19500.471361532",
           "timestamp": 1513555200000
         },
         "penalty": false
       }
     ]
   }
 }
 */

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
