//
//  AddToPortfolioView.swift
//  Stocks
//
//  Created by Jan Honsbrok on 19.11.22.
//

import Foundation
import SwiftUI

struct AddToPortfolioView: View {
  var stock: Stock
  var portfolio: Portfolio
  var portfolioHandler: PortfolioHandler

  @State var input = "1"
  var body: some View {
    VStack {
      HStack {
        Text("Amount")
        TextField("", text: $input)
          .padding()
          .keyboardType(.decimalPad)
          .textFieldStyle(.roundedBorder)
      }.padding()
      HStack {
        Text("Money spend")
        Text(String(amountSpend()))
        Spacer()
      }.padding()
      Button {

        do {
          try portfolioHandler.addToPortfolio(
            stockId: stock.id, amount: stockNumberToPurchase(), pricePerUnit: 50, date: Date(),
            onComplete: { portfolioEntry in
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                portfolio.addStockToPortfolio(portfolioEntry: portfolioEntry)
              }
            })
        } catch {
          print("error when adding to portfolio \(error)")
        }
        NavigationUtils.popToRootView()

      } label: {
        Text("Add to portfolio")
      }.buttonStyle(.borderedProminent)
    }.navigationTitle(stock.name)

  }
  func stockNumberToPurchase() -> Int {
    return Int(input) ?? 0
  }
  func amountSpend() -> Int {
    return Int(stock.getValue()) * (Int(input) ?? 0)
  }
}
