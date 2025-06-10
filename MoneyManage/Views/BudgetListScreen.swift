//
//  BudgetListScreen.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import SwiftUI
import CoreData
struct BudgetListScreen : View {
    @State private var isPresented : Bool = false
    @Environment(\.managedObjectContext) private var context
//    @Environment(\.dismiss) var dismiss
//    @FetchRequest(sortDescriptors: []) private var expenses : FetchedResults<Expense>
    @FetchRequest(sortDescriptors: []) private var budgets : FetchedResults<Budget>
    private func delete(index: IndexSet){
        index.forEach { index in
            let budget = budgets[index]
            context.delete(budget)
            do {
                try context.save()
            }catch{
                fatalError()
            }
        }
    }
    var body: some View {
        VStack{
            List (budgets){ budget in
                NavigationLink{
                    BudgetDetailScreen(budget: budget)
                } label : {
                    BudgetCellView(budget: budget)
                }
            }
//            .onLongPressGesture { index in
//                delete(index: index)
//            }
        }.navigationTitle("Budgets")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Budget"){
                        isPresented = true
                        
                        
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetScreen() .presentationDetents([.medium])
            }
    }
}
#Preview {
    NavigationStack{
        BudgetListScreen()
    }
    .environment(\.managedObjectContext,CoreDataProvider.preview.context)
}


