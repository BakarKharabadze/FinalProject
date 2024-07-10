//
//  PastFirstRace.swift
//  
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import SwiftUI
import Domain

struct PastFirstRace: View {
    let race: RaceEntity

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor(white: 0.15, alpha: 1.0)))
                .frame(width: 345, height: 230)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Round \(race.round)")
                            .foregroundColor(.blue)
                            .padding(.bottom, 2)
                        
                        Text(race.grandPrixName)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 1)
                        
                        Text(race.date)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "flag.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 30)
                        .foregroundColor(.blue)
                        .padding()
                }
                
                HStack(spacing: 50) {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 70)
                        Text("Hamilton")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 70)
                        Text("Verstappen")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50, height: 70)
                        Text("Norris")
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
