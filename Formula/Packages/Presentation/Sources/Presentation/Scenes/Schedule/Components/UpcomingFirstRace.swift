//
//  UpcomingFirstRace.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import SwiftUI

struct UpcomingFirstRace: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor(white: 0.15, alpha: 1.0)))
                .frame(width: 345, height: 230)
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Round 03")
                        .foregroundColor(.yellow)
                        .padding(.bottom, 2)
                    
                    Text("Australian GP")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    
                    Text("22-24 March")
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("Starts in")
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    HStack(spacing: 8) {
                        Text("04")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 4)
                        
                        Text("16")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 5)
                        
                        Text("40")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 0)
                    }
                    .padding(.bottom, 2)
                    
                    HStack(spacing: 24) {
                        Text("Days")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        
                        Text("Hours")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        
                        Text("Minutes")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .padding(.leading, -10)
                    }
                }
                .padding()
                
                Spacer()
    
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    UpcomingFirstRace()
}
