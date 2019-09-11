//
//  StocksDVC.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import UIKit

class StocksDVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbsImage: UIImageView!
    @IBOutlet weak var openingPriceLabel: UILabel!
    @IBOutlet weak var closingPriceLabel: UILabel!
    
    var stock: Stock! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStockDVC()
    }

    private func configureStockDVC () {
     //   openingPriceLabel.text = "open: \(stock.openPrice)"
//        dateLabel.text = stock.getStringDate()
//        openingPriceLabel.text = stock.openingPrice.description
//        closingPriceLabel.text = stock.closingPrice.description
        dateLabel.text = stock.date
        openingPriceLabel.text = "open: \(stock.openingPrice)"
        closingPriceLabel.text = "close: \(stock.closingPrice)"
        
        if stock.stockComparison() == true {
            thumbsImage.image = UIImage(named: "thumbsUp")
            view.backgroundColor = .green
        } else {
            thumbsImage.image = UIImage(named: "thumbsDown")
            view.backgroundColor = .red 
        }
    }
}
