//
//  RaceView.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import SwiftUI
import Domain

struct RaceView: View {
    let race: RaceEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(race.countryFlag, bundle: .module)
                        .resizable()
                        .frame(width: 25, height: 15)
                    Text(race.date)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                .padding(.leading, -15)
                .padding(.top, -10)
                
                Text(race.grandPrixName)
                    .foregroundColor(.white)
                    .font(.title)
                    .lineLimit(nil)  // Enable unlimited lines
                    .padding(.top, -3)
                    .padding(.leading, -16)
                
                Text("Formula 1 Rolex Australian Grand Prix 2024")
                    .font(.system(size: 10))
                    .padding(.top, -9)
                    .padding(.leading, -15)
                    .foregroundColor(.white)
            }
            .padding()
            
            Spacer()
            
            Image(race.date, bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .padding()
                .offset(x: 35)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CustomCellBackground"))
        )
        .frame(width: 340, height: 150)
        .cornerRadius(10)
    }
}
