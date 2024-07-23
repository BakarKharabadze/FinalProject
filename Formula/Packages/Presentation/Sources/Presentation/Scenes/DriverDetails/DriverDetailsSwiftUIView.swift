//
//  DriverDetailsSwiftUIView.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import SwiftUI
import Domain

struct DriverDetailsSwiftUIView: View {
    
    //MARK: - Properties
    var driverDetails: DriverDetailsEntity
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            horizontalLabel(labelText: "Races:", valueText: driverDetails.races)
            horizontalLabel(labelText: "World Titles:", valueText: driverDetails.worldTitle)
            horizontalLabel(labelText: "Race Wins:", valueText: driverDetails.raceWins)
            horizontalLabel(labelText: "Podiums:", valueText: driverDetails.podiums)
            horizontalLabel(labelText: "Nationality:", valueText: driverDetails.nationality)
            horizontalLabel(labelText: "Birthday:", valueText: driverDetails.birthday)
            horizontalLabel(labelText: "Birth Place:", valueText: driverDetails.birthPlace)
        }
        .padding()
        .background(Color("CustomCellBackground"))
        .cornerRadius(10)
    }
    
    //MARK: - Methods
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

