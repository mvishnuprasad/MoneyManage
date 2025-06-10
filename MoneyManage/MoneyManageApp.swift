//
//  MoneyManageApp.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import SwiftUI

@main
struct MoneyManageApp: App {
    
    let provider = CoreDataProvider()
  

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                BudgetListScreen()
            }
            .environment(\.managedObjectContext, provider.context)
        }
    }
}
