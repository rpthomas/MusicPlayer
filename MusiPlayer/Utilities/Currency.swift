//
//  Currency.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 2/20/21.
//

import Foundation

class CurrencyFormatter {
    static var outputFormatter = CurrencyFormatter.create()
    class func create(locale: Locale = Locale.current,
                      groupingSeparator: String? = nil,
                      decimalSeparator: String? = nil,
                      style: NumberFormatter.Style = NumberFormatter.Style.currency) -> NumberFormatter {
        let outputFormatter = NumberFormatter()
        outputFormatter.locale = locale
        outputFormatter.decimalSeparator = decimalSeparator ?? locale.decimalSeparator
        outputFormatter.groupingSeparator = groupingSeparator ?? locale.groupingSeparator
        outputFormatter.numberStyle = style
        return outputFormatter
    }
}

extension Numeric {
    func toCurrency(formatter: NumberFormatter = CurrencyFormatter.outputFormatter) -> String? {
        guard let num = self as? NSNumber else { return nil }
        var formatedSting = formatter.string(from: num)
        guard let locale = formatter.locale else { return formatedSting }
        if let separator = formatter.groupingSeparator, let localeValue = locale.groupingSeparator {
            formatedSting = formatedSting?.replacingOccurrences(of: localeValue, with: separator)
        }
        if let separator = formatter.decimalSeparator, let localeValue = locale.decimalSeparator {
            formatedSting = formatedSting?.replacingOccurrences(of: localeValue, with: separator)
        }
        return formatedSting
    }
    
   
}
