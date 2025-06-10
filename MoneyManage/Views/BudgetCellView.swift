//
//  BudgetCellView.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import SwiftUI
struct BudgetCellView: View {
    let budget : Budget
    var body: some View {
        HStack{
            Text(budget.title ?? "")
            Spacer()
            Text(budget.amount, format:  .currency(code: Locale.current.currency?.identifier ?? "$"))
        }
    }
}
