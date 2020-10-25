//
//  String+CapitalizeFirstLetter.swift
//  Moonshot
//
//  Created by Jacob on 10/25/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
    
}
