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
        //        _expenses = FetchRequest(entity: Expense.entity(),sortDescriptors: [],predicate:NSPredicate(format: "budget == %@", budget))
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
        }
    }
    let budget : Budget
    var body: some View {
        Form{
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
                            Text("Total Budget")
                            Spacer()
                            Text(total, format:  .currency(code: Locale.currencyCode ))
                        }
                        HStack {
                            Text("Remaining Budget")
                            Spacer()
                            Text(remaining, format:  .currency(code: Locale.currencyCode ))
                                .foregroundStyle(remaining<0 ? .red : .green)
                        }
                    }
                    ForEach (expenses){ expense in
                        HStack{
                            Text(expense.title ?? "")
                            Spacer()
                            Text(expense.amount, format:  .currency(code: Locale.currencyCode))
                        }
                    }
                }
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
