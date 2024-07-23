//
//  RaceView.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import SwiftUI
import Domain

struct RaceView: View {
    
    //MARK: - Properties
    let race: RaceEntity
    
    //MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(race.grandPrixName, bundle: .module)
                        .resizable()
                        .frame(width: 25, height: 15)
                    Text(race.date)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                .padding(.top, -30)
                .padding(.leading, 0)
                
                Text(race.grandPrixName)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, -3)
                
                Text("Formula 1 \(race.grandPrixName) 2024")
                    .font(.system(size: 10))
                    .padding(.top, -9)
                    .foregroundColor(.white)
            }
            .scaledToFill()
            .padding(.trailing, -55)
            .padding(.top, 15)
            
            Image(race.date, bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .padding()
                .offset(x: 30)
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
