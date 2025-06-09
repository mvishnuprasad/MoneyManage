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
    var body: some View {
        VStack{
            Text("Budget")
        }.navigationTitle("Budgets")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Budget"){
                        isPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddBudgetScreen()
            }
    }
}
#Preview {
    NavigationStack{
        BudgetListScreen()
    }
}
