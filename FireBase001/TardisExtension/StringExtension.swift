//
//  StringExtension.swift
//  Heya
//
//  Created by TrungNV on 10/12/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func trim() -> String {
          return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      }
    
    func split(_ delimiter: String) -> [String] {
           return self.components(separatedBy: delimiter)
       }
}

extension Optional where Wrapped == String {
    func value(_ defaultValue: String = "") -> String {
        return self ?? defaultValue
    }
}
