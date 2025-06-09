//
//  Budget+Extensions.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import CoreData
extension  Budget {
    static func exists (context: NSManagedObjectContext, title: String)->Bool {
        
        let req = Budget.fetchRequest()
        req.predicate = NSPredicate(format: "title == %@", title)
        do {
            let results = try context.fetch(req)
            return !results.isEmpty
        } catch {
            fatalError()
        }
    }
}
