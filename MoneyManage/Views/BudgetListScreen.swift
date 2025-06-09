//
//  BudgetListScreen.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import SwiftUI

struct BudgetListScreen : View {
    @State private var isPresented : Bool = false
    @FetchRequest(sortDescriptors: []) private var budgets : FetchedResults<Budget>
    var body: some View {
        VStack{
            List (budgets){ budget in
                BudgetCellView(budget: budget)
            }
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


