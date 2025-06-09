//
//  MoneyManageApp.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import SwiftUI

@main
struct MoneyManageApp: App {
    
    let provider : CoreDataProvider
    init() {
        provider = CoreDataProvider()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, provider.persistantContainer.viewContext)
        }
    }
}
