//
//  StockDetailViewController.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import UIKit

class StockDetail: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
     var stock: Stock?


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let stock = stock {
            dateLabel.text = stock.date
            openLabel.text = "Open: $" + String(format: "%.2f", stock.open)
            closeLabel.text = "Close: $" + String(format: "%.2f", stock.close)
            if stock.open > stock.close {
                imageView.image = UIImage(named: "thumbsUp")
                view.backgroundColor = .green
            } else {
                imageView.image = UIImage(named: "thumbsDown")
                view.backgroundColor = .red
            }
        }
        
    }
    

}
