//
//  Mission.swift
//  Moonshot
//
//  Created by Jacob on 10/23/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            //format launchDate to a string with specific .long style
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            //launchDate was nil, return N/A
            return "N/A"
        }
    }
    
}

