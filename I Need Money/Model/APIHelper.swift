//
//  APIHelper.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 02/10/2020.
//

import UIKit

class APIHelper {
    
    static private let _shared = APIHelper() // Singleton privée
    static var shared: APIHelper {
        return _shared
    }
    
    // MARK: Get API
    func getApi(currency: String, period: String, completion: (([Coin], Error?) -> Void)?) {
        // https://docs.coinranking.com
        let baseString = "https://api.coinranking.com/v1/public/coins"
        let currency = "base=\(currency.uppercased())"  // parametre Devise
        let period = "timePeriod=\(period)"             // parametre Période
        
        let urlString = baseString + "?" + currency + "&" + period
        // https://api.coinranking.com/v1/public/coins?base=EUR&timePeriod=24h
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (d, r, e) in
                // S'il y a des Données
                DispatchQueue.main.async {
                    if let data = d {
                        print("Data: \(data)")
                        do {
                            let result = try JSONDecoder().decode(APIResponse.self, from: data) // Thread secondaire
                            let datas = result.data.coins
                            //DispatchQueue.main.async { // Thread principal
                                //self.datas = datas
                                //self.tableView.reloadData()
                                completion?(datas, nil)
                            //}
                        } catch {
                            completion?([], error)
                            print(error.localizedDescription)
                        }
                    }
                    // S'il y a une Réponse
                    if let response = r {
                        print("Response: \(response)")
                    }
                    // S'il y a une Erreur
                    if let error = e {
                        completion?([], error)
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        } else {
            //completion?( [], "Cette URL n'existe pas" )
            print("Cette URL n'existe pas")
        }
    }

}
