//
//  StocksViewController.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    
    @IBOutlet weak var stockTableview: UITableView!
    
    var stocks = [Stock]()
    var groupedStocks = [String: [Stock]]()
    var stockSections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    
    private func configureTableView() {
        stockTableview.delegate = self
        stockTableview.dataSource = self
    }
    
    private func loadData() {
        if let pathToData = Bundle.main.path(forResource: "stocks", ofType: "json") {
            let internalUrl = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: internalUrl)
                let newStockFromJSON = try Stock.getStock(from: data)
                stocks = newStockFromJSON
                groupedStocks = Stock.buildGroupStock(stocks)
                stockSections = Array(groupedStocks.keys)
                stockSections = Stock.sortedSections(array: stockSections)
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StocksDVC,
            let indexPath = stockTableview.indexPathForSelectedRow else {return}
        print(indexPath.row)
        let selectedStock = stocks[indexPath.row]
        destination.stock = selectedStock
    }

    
    
}
extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = stockSections[section]
        guard let stocks = groupedStocks[sectionKey] else {
            fatalError("no stock data found")
        }
        return stocks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockSections.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = stockSections[indexPath.section]
        guard let stocks = groupedStocks[sectionKey] else {
            fatalError("no grouped stocks")
        }
        let currentStock = stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        cell.textLabel?.text = currentStock.getStringDate()
        cell.detailTextLabel?.text = String(currentStock.openingPrice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionKey = stockSections[section]
        guard let stocks = groupedStocks[sectionKey] else {
            fatalError("no grouped stocks for title in section header")
        }
        return "\(sectionKey.changeDateFormatForHeader(dateFormat: "yyyy-MM"))                            Average Price: $\(Stock.getStockAverage(array: stocks)))"
    }
    
}
