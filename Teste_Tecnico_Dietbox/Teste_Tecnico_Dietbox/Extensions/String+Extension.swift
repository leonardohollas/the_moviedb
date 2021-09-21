//
//  String+Extension.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 21/09/21.
//

import UIKit

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDateToDate = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        let strdate = dateFormatter.string(from: strDateToDate as Date)
        return strdate
    }
}
