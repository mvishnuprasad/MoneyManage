//
//  Locale+Extensions.swift
//  MoneyManage
//
//  Created by vishnuprasad on 10/06/25.
//

import Foundation
extension Locale{
    
    static var currencyCode : String {
        Locale.current.currency?.identifier ?? "$"
    }
}
