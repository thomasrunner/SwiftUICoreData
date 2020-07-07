//
//  EntryField.swift
//  SwiftUICoreData
//
//  Created by Thomas on 2020-07-06.
//  Copyright © 2020 Thomas Lock. All rights reserved.
//
import SwiftUI
// Custom SwiftUI Text Field with minimal validation
struct EntryField: View {
    @Binding var entryModel: EntryModel
    @Binding var submitted: Bool
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(entryModel.title).font(.callout).bold()
            TextField(entryModel.title, text: $entryModel.value).textFieldStyle(RoundedBorderTextFieldStyle())
            if submitted && entryModel.value.isEmpty {
                Text(entryModel.inlineError).font(.footnote).foregroundColor(Color.red)
            }
        }
    }
}
#if DEBUG
struct EntryField_Previews: PreviewProvider {
    @State static var submitted: Bool = true
    @State static var symbolModel = EntryModel(title: "Stock Symbol", value: "", inlineError: "Please enter stock symbol!")
    static var previews: some View {
        EntryField(entryModel: $symbolModel, submitted: $submitted)
    }
}
#endif



