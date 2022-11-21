//
//  Portfolio.swift
//  Stocks
//
//  Created by Carlo Beckmann on 09.11.22.
//

import Foundation

class Portfolio: ObservableObject {
  @Published var stocks: [PortfolioEntry]

  init(stocks: [PortfolioEntry]) {
    self.stocks = stocks
  }

  func totalValue() -> Double {
    return stocks.map { $0.calculateStockValue() }.reduce(0, +)
  }

  func isEmpty() -> Bool {
    return stocks.isEmpty
  }

  func addStockToPortfolio(stock: Stock, amount: Int) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      var existingEntryIndex = self.stocks.firstIndex(where: { $0.stock.id == stock.id })
      if existingEntryIndex != nil {
        self.stocks[existingEntryIndex!].amount += Float(amount)
      } else {
        let entry = PortfolioEntry(stock: stock, amount: (Float)(amount))
        self.stocks.append(entry)
      }
      self.stocks = self.stocks
    }
  }
}
