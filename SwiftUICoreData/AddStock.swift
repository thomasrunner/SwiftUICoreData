//
//  AddStock.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-05.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//
import SwiftUI

struct EntryModel {
    var title: String
    var value: String
    var inlineError: String
}

struct AddStock: View {
    
    // State and Environment variables
    @State var submitted: Bool = false
    @State var symbolModel = EntryModel(title: "Stock Symbol", value: "", inlineError: "Please enter stock symbol!")
    @State var descriptionModel = EntryModel(title: "Stock Description", value: "", inlineError: "Please enter stock symbol description!")
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                
                    //Custom TextField entry view using simple MVVM pattern
                    EntryField(entryModel: $symbolModel, submitted: $submitted)
                    EntryField(entryModel: $descriptionModel, submitted: $submitted)
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
        if !descriptionModel.value.isEmpty  && !symbolModel.value.isEmpty {
            let context = ((UIApplication.shared.delegate as? AppDelegate)?.managedContext())
            let newStock = Stock(entity: Stock.entity(), insertInto: context)
            newStock.symbol = self.symbolModel.value
            newStock.name = self.descriptionModel.value
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
