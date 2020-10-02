//
//  ViewController.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import UIKit
//import PocketSVG

// https://github.com/public-apis/public-apis

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datas: [Coin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //getApi(currency: "EUR", period: "24h")
        //APIHelper().getApi(currency: "EUR", period: "24h") { (coins, error) in
        APIHelper.shared.getApi(currency: "EUR", period: "24h") { (coins, error) in // Singleton privé "_shared" de APIHelper
            self.datas = coins
            if error != nil {
                //Alerthelper().errorAlert(error!.localizedDescription, viewController: self)
                Alerthelper.get.errorAlert(error!.localizedDescription, viewController: self) // Singleton "get" de AlertHelper
            }
            
            self.tableView.reloadData()
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

