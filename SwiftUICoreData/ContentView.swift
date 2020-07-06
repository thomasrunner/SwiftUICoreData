//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-02.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    // State and Environment variables
    @State private var showingSheet = false
    @FetchRequest(
        entity: Stock.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Stock.name, ascending: true)
        ]
    ) var stocks: FetchedResults<Stock>
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(stocks, id: \.self) { stock in
                    HStack() {
                        Text(stock.symbol ?? "Unknown").frame(width: 60, height: 40, alignment: .leading)
                        Text(stock.name ?? "Unknown")
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("SwiftUI + CoreDate")
            .navigationBarItems(leading: Button(action: {
                self.showingSheet = true
            }) {
                Image(systemName: "plus")
            }, trailing: EditButton()).sheet(isPresented: $showingSheet, content: {
                AddStock().environment(\.managedObjectContext, ((UIApplication.shared.delegate as? AppDelegate)?.managedContext())!)
            })
        }
    }
    
    // Deletes the selected stock symbol from core data and saves the changes.
    fileprivate func delete(at offsets: IndexSet) {
        let context = ((UIApplication.shared.delegate as? AppDelegate)?.managedContext())
        for index in offsets {
            let stock = stocks[index]
            context?.delete(stock)
        }
        (UIApplication.shared.delegate as? AppDelegate)?.coreData.saveContext()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
