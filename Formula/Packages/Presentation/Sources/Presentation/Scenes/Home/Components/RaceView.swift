//
//  RaceView.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import SwiftUI

struct RaceView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("AustraliaFlag", bundle: .module)
                        .resizable()
                        .frame(width: 25, height: 15)
                    Text("00-00 January")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                .padding(.leading, -15)
                .padding(.top, -10)
                
                Text("Australia")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.top, -3)
                    .padding(.leading, -16)
                
                Text("Formula 1 Rolex australian grand prix 2024")
                    .font(.system(size: 10))
                    .padding(.top, -9)
                    .padding(.leading, -15)
                    .foregroundColor(.white)
            }
            .padding()
            
            Spacer()
            
            Image("Australia", bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 250)
                .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
        )
        .frame(width: 340, height: 150)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    RaceView()
}

