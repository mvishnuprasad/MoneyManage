//
//  BudgetDetailScreen.swift
//  MoneyManage
//
//  Created by vishnuprasad on 10/06/25.
//

import SwiftUI

struct BudgetDetailScreen: View {
    @State private var title : String = ""
    @State private var amount : Double?
    
    let budget : Budget
    var body: some View {
        Form{
            Section("New Expense"){
                TextField("Title", text: $title)
                TextField("Limit",value: $amount,format: .number)
                    .keyboardType(.numberPad)
                Button(action: {}) {
                    Text("Save")
                        .frame(maxWidth:.infinity)
                }.buttonStyle(.borderedProminent)
                    .disabled(!Budget.isFormValid(title: title, amount: amount))
            }
        }.navigationTitle(budget.title ?? "")
    }
}


/// Preview
struct BudgetContainer : View {
    @FetchRequest(sortDescriptors:[]) private var budget : FetchedResults<Budget>

    var body: some View {
        BudgetDetailScreen(budget: budget[0])
    }
}
#Preview {
    BudgetContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
