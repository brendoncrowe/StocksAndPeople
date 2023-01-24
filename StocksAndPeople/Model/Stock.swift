//
//  Stock.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import Foundation

struct Stock: Decodable {
    let date: String
    let uClose: Double
    let uOpen: Double
    let uHigh: Double
    let uLow: Double
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let label: String
}

extension Stock {
    static func fetchStocks() -> [Stock] {
        var stocks = [Stock]()
        let data = Bundle.readRawJSONData(filename: "applestockinfo", ext: "json")
        
        do {
            let results = try JSONDecoder().decode([Stock].self, from: data)
            stocks = results
        } catch {
            fatalError("could not load stocks")
        }
        return stocks
    }
    
    static func stockDateSections() -> [[Stock]] {
        let stocks = fetchStocks()
        
        // this function needs to sort by label, which is the month abbreviation
        var monthSection = Set([String]()) // must be a set in order to have only 1 "Aug"
        
        // the below function is a way of going through each stock, getting the month and year, and inserting it into monthSection
        
        for stock in stocks {
            var date = stock.label // Aug 29, 17
            var dateSection = date.components(separatedBy: " ") // Aug 29, 17
            dateSection.remove(at: 1) // Aug  17
            date = dateSection.joined() // Aug17
            monthSection.insert(date)
        }
        
        var sections = Array(repeating: [Stock](), count: monthSection.count) // 25 months
        var currentIndex = 0
        var currentMonth = stocks.first?.label.components(separatedBy: " ").first ?? "" // Aug
        for stock in stocks {
            let month = stock.label.components(separatedBy: " ").first ?? ""
            if month == currentMonth {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentMonth = stock.label.components(separatedBy: " ").first ?? ""
                sections[currentIndex].append(stock)
            }
        }
        return sections
    }
}
