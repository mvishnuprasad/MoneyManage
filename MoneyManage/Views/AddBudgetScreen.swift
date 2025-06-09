//
//  AddBudgetScreen.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import SwiftUI

struct AddBudgetScreen: View {
    @State private var title : String = ""
    @State private var limit : Double?
    @Environment(\.managedObjectContext) private var context
    private var isFormValid : Bool {
        !title.isEmptyOrSpace && limit != nil && Double(limit!) > 0
    }
    private func save() {
        let budget = Budget(context: context)
        budget.title = title
        budget.amount = limit ?? 0
        budget.dateCreated = Date()
        do {
            try context.save()
        }catch{
            print("Error Saving")
        }
    }
    var body: some View {
        Form {
            Text("New Budget")
                .font(.title)
                .font(.headline)
            TextField("Title",text: $title)
                .presentationDetents([.medium])
            TextField("Limit",value: $limit,format: .number)
                .keyboardType(.numberPad)
            Button {
                if !Budget.exists(context: context, title: title){
                    save()
                }else{
                    
                }
                
            } label: {
                Text("Save")
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            .presentationDetents([.medium])
            
            
        }
    }
}

#Preview {
    AddBudgetScreen()
        .environment(\.managedObjectContext,CoreDataProvider.preview.context)
}
