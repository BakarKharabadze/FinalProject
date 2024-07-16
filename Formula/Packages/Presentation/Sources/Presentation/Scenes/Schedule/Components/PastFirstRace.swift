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
                .fill(Color("CustomCellBackground"))
                .frame(width: 350, height: 260)
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
                    
                    Image("Bahrein", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                }
                
                HStack(spacing: 50) {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image("Lewis", bundle: .module)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 70)
                            Text("1")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding([.top, .leading], -4)

                        }
                        Text("Hamilton")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image("Verstappen", bundle: .module)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            Text("2")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding([.top, .leading], -4)
                        }
                        Text("Verstappen")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        ZStack(alignment: .topLeading) {
                            Image("Lando", bundle: .module)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 70)
                            Text("3")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding([.top, .leading], -4)
                        }
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
