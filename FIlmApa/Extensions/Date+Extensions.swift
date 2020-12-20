//
//  Date+Extensions.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import Foundation
extension String {
    func getYear(with format: String = "yyyy-MM-dd") -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = format

         let oldDate = olDateFormatter.date(from: self)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
}
