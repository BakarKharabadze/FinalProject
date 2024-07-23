//  RaceWeekendView.swift
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import SwiftUI
import Domain

struct RaceWeekendView: View {
    var race: RaceEntity
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Race weekend")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                raceSessionView(date: race.practiceOneDate, title: "Practice 1", time: race.practiceOneTime)
                Divider()
                raceSessionView(date: race.practiceTwoDate, title: "Practice 2", time: race.practiceTwoTime)
                Divider()
                raceSessionView(date: race.practiceThreeDate, title: "Practice 3", time: race.practiceThreeTime)
                Divider()
                raceSessionView(date: race.qualificationDate, title: "Qualifying", time: race.qualificationTime)
                Divider()
                raceSessionView(date: race.date, title: "Race", time: race.time)
            }
        }
        .padding()
        .background(Color("CustomCellBackground"))
        .cornerRadius(10)
        .padding()
    }
    
    //MARK: - Methods
    private func raceSessionView(date: String, title: String, time: String) -> some View {
        HStack {
            VStack {
                let (day, month) = formattedDate(date)
                Text(day)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(month)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(width: 50)
            .background(Color.black.opacity(0.1))
            .cornerRadius(8)
            
            Divider()
                .frame(height: 40)
                .padding(.horizontal, 5)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                Text(time)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    //MARK: - Date Formater
    private func formattedDate(_ date: String) -> (String, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateObject = dateFormatter.date(from: date) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: dateObject)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM"
            let month = monthFormatter.string(from: dateObject)
            
            return (day, month)
        } else {
            return (date, "")
        }
    }
}
