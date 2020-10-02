//
//  CurrencyCell.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 11/09/2020.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var coin: Coin! {
        didSet {
            nameLbl.text = coin.name
            priceLbl.text = coin.price
            if let urlString = coin.iconUrl {
                if let url = URL(string: urlString) {
                    print(urlString)
                    URLSession.shared.dataTask(with: url) { (d, _, _) in
                        if let data = d {
                            print(data)
                            let img = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.icon.image = img
                            }
                        }
                    }.resume()
                }
            }
        }
    }
}
