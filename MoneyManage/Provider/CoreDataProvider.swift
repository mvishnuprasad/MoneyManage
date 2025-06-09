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
    static var preview : CoreDataProvider = {
        let provider = CoreDataProvider(inMemory: true)
        let context = provider.context
        let celeb = Budget(context: context)
        celeb.title = "BirthDay"
        celeb.amount = 250.0
        celeb.dateCreated = Date()
        do {
            try context.save()
        }catch {
            fatalError()
        }
        return provider
    }()
    init(inMemory : Bool = false) {
        self.persistantContainer = NSPersistentContainer(name: "MoneyManage")
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
