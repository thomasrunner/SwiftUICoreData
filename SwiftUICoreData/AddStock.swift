//
//  AddStock.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-05.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//

import SwiftUI

struct AddStock: View {
    
    // Simple constants
    let stockSymbolTitle: String = "Stock Symbol"
    let stockDescriptionTitle: String = "Stock Description"
    
    // State and Environment variables
    @State private var stockSymbol: String = ""
    @State private var stockDescription: String = ""
    @State private var submitted: Bool = false
    @Environment(\.presentationMode) private var presentationMode
        
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(self.stockSymbolTitle).font(.callout).bold()
                    TextField(self.stockSymbolTitle, text: $stockSymbol).textFieldStyle(RoundedBorderTextFieldStyle())
                    if submitted && stockSymbol.isEmpty {
                        Text("Please enter stock symbol!").font(.footnote).foregroundColor(Color.red)
                    }
                    Text(self.stockDescriptionTitle).font(.callout).bold()
                    TextField(self.stockDescriptionTitle, text: $stockDescription).textFieldStyle(RoundedBorderTextFieldStyle())
                    if submitted && stockDescription.isEmpty {
                        Text("Please enter stock symbol description!").font(.footnote).foregroundColor(Color.red)
                    }
                    Spacer()
                    Button(action: {
                        self.addStockSymbol()
                    }) {
                        Text("Add Stock")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(8.0, antialiased: true)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(8.0, antialiased: true)
                            .font(.body)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }.padding(EdgeInsets.init(top: 10, leading: 20, bottom: 20, trailing: 20))
                
            }
            .navigationBarTitle("Add New Stock")
        }
    }
        
    // Adds the new symbol to core data if there are valid values and saves the changes.
    fileprivate func addStockSymbol() {
        if !stockDescription.isEmpty  && !stockSymbol.isEmpty {
            let context = ((UIApplication.shared.delegate as? AppDelegate)?.managedContext())
            let newStock = Stock(entity: Stock.entity(), insertInto: context)
            newStock.symbol = self.stockSymbol
            newStock.name = self.stockDescription
            (UIApplication.shared.delegate as? AppDelegate)?.coreData.saveContext()
            self.presentationMode.wrappedValue.dismiss()
        } else {
            self.submitted = true
        }
    }
}

struct AddStock_Previews: PreviewProvider {
    static var previews: some View {
        AddStock()
    }
}
