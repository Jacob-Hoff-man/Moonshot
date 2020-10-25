//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Jacob on 10/23/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        //load URL from project Bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        //load data from the URL
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        //creating JSON decoder
        let decoder = JSONDecoder()
        
        //setting up a date formatter with specific format to parse date data
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        //decode from data into constant loaded of type [Astronaut].self
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        
        return loaded
    }
}
