//
//  ViewController.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datas: [Coin] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getApi("EUR", "24h")
    }
    
    
    func getApi(_ currency: String, _ period: String) {
        let baseString = "https://api.coinranking.com/v1/public/coins"
        let currency = "base=\(currency.uppercased())"
        let period = "timePeriod=\(period)"
        let urlString = baseString + "?" + currency + "&" + period
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (d, r, e) in
                if let data = d {
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
                
                if let error = e {
                    print("Error: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            print("Cette URL n'existe pas")
        }
    }
    
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

