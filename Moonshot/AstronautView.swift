//
//  AstronautView.swift
//  Moonshot
//
//  Created by Jacob on 10/24/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    
    let astronaut: Astronaut
    let missions: [(name: String, date: String)]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("\(self.astronaut.name) was a member of the following missions:")
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions, id: \.name) { mission in
                        Text("\(mission.name), launch date \(mission.date)")
                        .italic()
                        .padding()
                        .layoutPriority(1)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        
    }
    
}



struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: [(missions[0].displayName, missions[0].formattedLaunchDate), (missions[1].displayName, missions[1].formattedLaunchDate)])
    }
}
