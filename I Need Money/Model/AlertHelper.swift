//
//  AlertHelper.swift
//  I Need Money
//
//  Created by Rodolphe DUPUY on 02/10/2020.
//

import UIKit

class Alerthelper {
    
    static let get = Alerthelper() // Singleton pour rendre les instance accessible plus facilement
    
    func errorAlert(_ message: String, viewController: UIViewController) {
        let controller = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        controller.addAction(ok)
        viewController.present(controller, animated: true, completion: nil)
    }
}
