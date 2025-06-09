//
//  CoreDataProvider.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import CoreData
class CoreDataProvider {
    let persistantContainer : NSPersistentContainer
    var context : NSManagedObjectContext{
        persistantContainer.viewContext
    }
    
    init(inMemory : Bool = false) {
        self.persistantContainer = NSPersistentContainer(name: "MoneyManageModel")
        if (inMemory){
            persistantContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        persistantContainer.loadPersistentStores { _, error in
            if let error {
                print("Error occured \(error)")
            }
        }
    }
}
