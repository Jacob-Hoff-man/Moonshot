//
//  ContentView.swift
//  Moonshot
//
//  Created by Jacob on 10/23/20.
//  Copyright © 2020 Jacob. All rights reserved.
//
// the data involved in this application with respect to astronauts/missions
// is credited to Wikipedia and their authors and is licensed under CC-BY-SA
// license here: https://creativecommons.org/licenses/by-sa/3.0/legalcode
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var buttonToggle = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(missionID: mission.id, missions: self.missions, astronauts: self.astronauts)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    if self.buttonToggle {
                        CrewNamesListView(mission: mission)
                    } else {
                        LaunchDateListView(mission: mission)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: (self.buttonToggle ? Button("Date") { self.buttonToggle.toggle() } : Button("Crew") { self.buttonToggle.toggle() }))
        }
    }
}

struct LaunchDateListView: View {
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mission.displayName)
                .font(.headline)
                .bold()
            
            Text(mission.formattedLaunchDate)
            .italic()
        }
    }
}

struct CrewNamesListView: View {
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mission.displayName)
                .font(.headline)
                .bold()
            
            ForEach(self.mission.crew, id: \.role) { crewMember in
                Text("\(crewMember.name.capitalizeFirstLetter()), \(crewMember.role)")
                .italic()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
