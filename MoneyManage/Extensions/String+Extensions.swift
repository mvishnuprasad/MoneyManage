//
//  String+Extensions.swift
//  MoneyManage
//
//  Created by vishnuprasad on 09/06/25.
//

import Foundation
import Foundation
extension String {
    var isEmptyOrSpace : Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
