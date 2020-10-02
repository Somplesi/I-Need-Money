//
//  ViewController.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import UIKit

// https://github.com/public-apis/public-apis

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datas: [Coin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getApi(currency: "EUR", period: "24h")
    }
    
    // MARK: Get API
    func getApi(currency: String, period: String) {
        // https://docs.coinranking.com
        let baseString = "https://api.coinranking.com/v1/public/coins"
        let currency = "base=\(currency.uppercased())"  // parametre Devise
        let period = "timePeriod=\(period)"             // parametre Période
        
        let urlString = baseString + "?" + currency + "&" + period
        // https://api.coinranking.com/v1/public/coins?base=EUR&timePeriod=24h
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (d, r, e) in
                // S'il y a des Données
                if let data = d {
                    print("Data: \(data)")
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        let datas = result.data.coins
                        DispatchQueue.main.async {
                            self.datas = datas
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                // S'il y a une Réponse
                if let response = r {
                    print("Response: \(response)")
                }
                // S'il y a une Erreur
                if let error = e {
                    print("Error: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            print("Cette URL n'existe pas")
        }
    }
    
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Currency") as? CurrencyCell {
            print("This cell")
            cell.coin = datas[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

