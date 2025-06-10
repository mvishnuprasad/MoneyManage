//
//  ExpenseCellView.swift
//  MoneyManage
//
//  Created by vishnuprasad on 10/06/25.
//

import SwiftUI

struct ExpenseCellView: View {
    var expense : Expense
    
    var body: some View {
        HStack{
            Text(expense.title ?? "")
            Spacer()
            Text(expense.amount, format:  .currency(code: Locale.currencyCode))
        }
    }
}
struct ExpenseCellViewContainer : View {
    @FetchRequest(entity: Expense(context: CoreDataProvider.preview.context).entity, sortDescriptors: []) private var expense : FetchedResults<Expense>
    var body: some View {
        ExpenseCellView(expense: expense[0])
    }
}

#Preview {
    ExpenseCellViewContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
