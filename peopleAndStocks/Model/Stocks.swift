//
//  Stocks.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let openingPrice: Double
    let closingPrice: Double
    
    private enum CodingKeys: String, CodingKey {
        case date
        case openingPrice = "open"
        case closingPrice = "close"
    }
    
    static func getStock(from data: Data) throws-> [Stock] {
        do {
            let newStock = try JSONDecoder().decode([Stock].self, from: data)
            return newStock
        } catch {
            throw appError.decodingError(error)
        }
    }
    
    func getDate() -> Date {
        return self.date.toDate(dateFormat: "yyyy-MM-dd")!
    }
    
    func getStringDate() -> String {
        return self.date.toDateFormatInString(dateFormat: "yyyy-MM-dd")
    }
    
    static func sortedDates(_ array: [Stock]) -> [Stock] {
        return array.sorted{ $0.getDate() < $1.getDate() }
    }
    
    func stockComparison() -> Bool {
        return closingPrice > openingPrice
    }
    
    static func getDateComponents(date: String) -> String {
        return String(date.dropLast(3))
    }
    
    static func getGroupedStocks (array: [Stock]) -> [String: [Stock]] {
        var dict = [String: [Stock]]()
        
        for stock in array {
            let key = Stock.getDateComponents(date: stock.date)
            if var stocks = dict[key]{
                stocks.append(stock)
                dict[key] = stocks
            } else {
                dict[key] = [stock]
            }
        }
        return dict
    }
    
    static func getStockAverage(array: [Stock]) -> Double {
        let sum = array.reduce(0, {$0 + $1.openingPrice})
        let average = sum / Double(array.count)
        
        return average.roundToTwoSpaces()
    }
    
    static func buildGroupStock(_ array: [Stock]) -> [String: [Stock]] {
        let sortStock = sortedDates(array)
        let groupedStocks = getGroupedStocks(array: sortStock)
        
        return groupedStocks
    }
    
    static func sortedSections(array: [String]) -> [String] {
        let sortedArray = array.sorted{$0.toDate(dateFormat: "yyyy-MM")! < $1.toDate(dateFormat: "yyyy-MM")! }
        return sortedArray
    }
}
    

extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateFormatInString(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    func changeDateFormatForHeader(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/yyyy"
        return formatter.string(from: date)
    }
    
}

extension Double {
    func roundToTwoSpaces() -> Double {
        let divisor: Double = 100
        return (self * divisor).rounded() / divisor
    }
}
