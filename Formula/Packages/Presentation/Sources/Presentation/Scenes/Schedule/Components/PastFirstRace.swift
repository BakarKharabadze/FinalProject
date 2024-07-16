//
//  PastFirstRace.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import SwiftUI
import Domain

struct PastFirstRace: View {
    let raceResult: RaceResultEntity

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("CustomCellBackground"))
                .frame(width: 350, height: 260)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Round \(raceResult.round)")
                            .foregroundColor(.blue)
                            .padding(.bottom, 2)
                        
                        Text(raceResult.grandPrixName)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 1)
                        
                        Text(raceResult.date)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(raceResult.grandPrixName, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                }
                
                HStack(spacing: 50) {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image(raceResult.firstPlaceLastName, bundle: .module)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 70)
                            Text("01")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: -5)

                        }
                        Text(raceResult.firstPlaceLastName)
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image(raceResult.secondPlaceLastName, bundle: .module)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            Text("02")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: 4)
                        }
                        Text(raceResult.secondPlaceLastName)
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image(raceResult.thirdPlaceLastName, bundle: .module)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 70)
                            Text("03")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: -6)
                        }
                        Text(raceResult.thirdPlaceLastName)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, -30)
                .padding(.leading, 15)
            }
            .padding()
        }
    }
}

struct PastFirstRace_Previews: PreviewProvider {
    static var previews: some View {
        PastFirstRace(
            raceResult: RaceResultEntity(
                round: "1",
                grandPrixName: "Australia",
                date: "2024-01-01",
                circuitId: "australia",
                firstPlaceLastName: "Verstappen",
                secondPlaceLastName: "Hamilton",
                thirdPlaceLastName: "Leclerc"
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
