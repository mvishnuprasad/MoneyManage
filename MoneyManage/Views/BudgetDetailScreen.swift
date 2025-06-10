//
//  BudgetDetailScreen.swift
//  MoneyManage
//
//  Created by vishnuprasad on 10/06/25.
//

import SwiftUI
import CoreData
struct BudgetDetailScreen: View {
    @State private var title : String = ""
    @State private var amount : Double?
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) private var expenses : FetchedResults<Expense>
    private var total : Double {
        return expenses.reduce(0){result , expense in
            expense.amount + result
        }
    }
    private var remaining : Double {
        return budget.amount - total
    }
    init(budget: Budget) {
        self.budget = budget
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "budget == %@", budget)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Expense.dateCreated, ascending: false)]
        _expenses = FetchRequest(fetchRequest: request)
    }
    private func addExpense() {
        let expense = Expense(context: context)
        expense.title = title
        expense.amount = amount ?? 0.0
        expense.dateCreated = Date()
        // expense.budget = budget
        budget.addToExpenses(expense)
        do {
            try context.save()
        }catch{
            fatalError()
        }
    }
    private func delete(index: IndexSet){
        index.forEach { index in
            let expense = expenses[index]
            context.delete(expense)
            do {
                try context.save()
            }catch{
                fatalError()
            }
        }
    }
    let budget : Budget
    var body: some View {
        Form{
            
            Text(budget.amount, format:  .currency(code: Locale.currencyCode ))
            Section("New Expense"){
                TextField("Title", text: $title)
                TextField("Limit",value: $amount,format: .number)
                    .keyboardType(.numberPad)
                Button(action: {
                    addExpense()
                    title = ""
                    amount = 0.0
                    dismiss()
                    
                }) {
                    Text("Save")
                        .frame(maxWidth:.infinity)
                }.buttonStyle(.borderedProminent)
                    .disabled(!Budget.isFormValid(title: title, amount: amount))
            }
            
            Section("Expenses") {
                List{
                    VStack (alignment: .leading){
                        HStack {
                            Text("Round Total")
                                .font(.callout)
                            Spacer()
                            Text(total, format:  .currency(code: Locale.currencyCode ))
                        }
                        HStack {
                            Text("Remaining Budget")
                                .font(.callout)
                            Spacer()
                            Text(remaining, format:  .currency(code: Locale.currencyCode ))
                                .foregroundStyle(remaining<0 ? .red : .green)
                                .font(.callout)
                        }
                    }
                    ForEach (expenses){ expense in
                        ExpenseCellView(expense: expense)
                    }.onDelete { index in
                        delete(index: index)
                    }
                }
            }
        }.navigationTitle(budget.title ?? "")
            .navigationBarTitleDisplayMode(.large)
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


