//
//  Data+Extension.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation

extension Data {
    var prettyString: NSString? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? nil
    }
}
