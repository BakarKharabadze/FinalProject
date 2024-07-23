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
    var teamDetails: TeamDetailsEntity

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            horizontalLabel(labelText: "World Titles:", valueText: teamDetails.worldTitle)
            horizontalLabel(labelText: "Race Wins:", valueText: teamDetails.raceWins)
            horizontalLabel(labelText: "Pole Positions:", valueText: teamDetails.polePositions)
            horizontalLabel(labelText: "Fastest Laps:", valueText: teamDetails.fastesLaps)
            horizontalLabel(labelText: "Base:", valueText: teamDetails.base)
            horizontalLabel(labelText: "President:", valueText: teamDetails.president)
            horizontalLabel(labelText: "Director:", valueText: teamDetails.director)
            horizontalLabel(labelText: "Technical Manager:", valueText: teamDetails.technicalManeger)
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
