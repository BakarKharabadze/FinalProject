//
//  UpcomingFirstRace.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import SwiftUI
import Domain

struct UpcomingFirstRace: View {
    let race: RaceEntity

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("CustomCellBackground"))
                .frame(width: 350, height: 260)
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Round \(race.round)")
                        .foregroundColor(.yellow)
                        .padding(.bottom, 2)
                    
                    Text(race.grandPrixName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    
                    Text(race.date)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("Starts in")
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                    
                    let remainingTime = calculateRemainingTime(from: race.date)
                    
                    HStack(spacing: 8) {
                        Text(remainingTime.days)
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 4)
                        
                        Text(remainingTime.hours)
                            .font(.title)
                            .foregroundColor(.yellow)
                            .padding(.horizontal, 5)
                        
                        Text(remainingTime.minutes)
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
    
                Image(race.round, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 130)
                    .offset(x: -5)
                    .padding()
            }
            .padding()
        }
    }
    
    private func calculateRemainingTime(from dateString: String) -> (days: String, hours: String, minutes: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let raceDate = dateFormatter.date(from: dateString) else {
            return ("00", "00", "00")
        }
        
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: currentDate, to: raceDate)
        
        let days = String(format: "%02d", components.day ?? 0)
        let hours = String(format: "%02d", components.hour ?? 0)
        let minutes = String(format: "%02d", components.minute ?? 0)
        
        return (days, hours, minutes)
    }
}

