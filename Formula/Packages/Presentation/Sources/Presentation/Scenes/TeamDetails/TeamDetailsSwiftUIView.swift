//
//  TeamDetailsSwiftUIView.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import SwiftUI
import Domain

struct TeamDetailsSwiftUIView: View {
    
    //MARK: - Properties
    var team: TeamDetailsEntity

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            horizontalLabel(labelText: "World Titles:", valueText: team.worldTitle)
            horizontalLabel(labelText: "Race Wins:", valueText: team.raceWins)
            horizontalLabel(labelText: "Pole Positions:", valueText: team.polePositions)
            horizontalLabel(labelText: "Fastest Laps:", valueText: team.fastesLaps)
            horizontalLabel(labelText: "Base:", valueText: team.base)
            horizontalLabel(labelText: "President:", valueText: team.president)
            horizontalLabel(labelText: "Director:", valueText: team.director)
            horizontalLabel(labelText: "Technical Manager:", valueText: team.technicalManeger)
        }
        .padding()
        .background(Color("CustomCellBackground"))
        .cornerRadius(10)
    }
    
    private func horizontalLabel(labelText: String, valueText: String) -> some View {
        HStack {
            Text(labelText)
                .font(.system(size: 16))
                .foregroundColor(.gray)
            Spacer()
            Text(valueText)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct TeamDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTeam = TeamDetailsEntity(
            name: "Red Bull Racing",
            worldTitle: "4",
            raceWins: "92",
            polePositions: "100",
            fastesLaps: "50",
            base: "Milton Keynes, UK",
            president: "Christian Horner",
            director: "Adrian Newey",
            technicalManeger: "Pierre Waché"
        )
        TeamDetailsSwiftUIView(team: sampleTeam)
            .background(Color.black)
            .previewLayout(.sizeThatFits)
            .cornerRadius(10)
    }
}
