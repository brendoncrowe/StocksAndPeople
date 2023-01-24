//
//  StocksTableViewController.swift
//  StocksAndPeople
//
//  Created by Brendon Crowe on 1/23/23.
//

import UIKit

class StocksTableView: UITableViewController {
    
    private var stockSections = [[Stock]]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        stockSections = Stock.stockDateSections()
    }
    
    
    private func getAverage(monthStocks: [Stock]) -> String {
        var total: Double = 0
        var average: Double = 0
        
        for monthStock in monthStocks {
            total += monthStock.open
        }
        average = total / Double(monthStocks.count)
        let averageString = String(format: "%.2f", average)
        return averageString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDVC = segue.destination as? StockDetail, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not load stock detail view controller")
        }
        stockDVC.stock = stockSections[indexPath.section][indexPath.row]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return stockSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionLabel = stockSections[section].first?.label
        var newLabel = sectionLabel?.components(separatedBy: " ")
        newLabel?.remove(at: 1)
        let finalLabel = newLabel?.joined(separator: " - 20")
        let average = getAverage(monthStocks: stockSections[section])
        return "\(finalLabel ?? " ")       Opening Average: \(average)"

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stockSections[indexPath.section][indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = stock.date
        content.secondaryText = "$\(stock.open)"
        cell.contentConfiguration = content
        return cell
    }

    

}
