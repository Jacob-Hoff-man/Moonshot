//
//  MissionView.swift
//  Moonshot
//
//  Created by Jacob on 10/24/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
        let missions: [(String, String)]
    }

    let missionID: Int
    let missions: [Mission]
    let mission: Mission
    let astronauts: [CrewMember]
   
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)      //0.7 is 70% geo size width
                        .padding(.top)
                    
                    Text("Launch date: \(self.mission.formattedLaunchDate)")
                        .font(.caption)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: crewMember.missions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                    
                }
            }
        }
        .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
    }
    
    init(missionID: Int, missions: [Mission], astronauts: [Astronaut]) {
        self.missionID = missionID
        self.missions = missions
        
        guard let mission = self.missions.first(where: { $0.id == missionID }) else {
                fatalError("missing mission with ID: \(missionID)")
            }
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                //get all missions that match was involved in
                var matchMissions = [(String, String)]()
                for mission in missions {
                    for member in mission.crew {
                        if member.name == match.id { matchMissions.append((mission.displayName, mission.formattedLaunchDate)) }
                    }
                }
                
                matches.append(CrewMember(role: member.role, astronaut: match, missions: matchMissions))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(missionID: missions[0].id, missions: missions, astronauts: astronauts)
    }
}
