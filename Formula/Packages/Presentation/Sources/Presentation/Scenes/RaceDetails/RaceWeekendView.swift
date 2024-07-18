//  RaceWeekendView.swift
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import SwiftUI

struct RaceWeekendView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Race weekend")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            ForEach(raceSessions, id: \.self) { session in
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        VStack {
                            Text(session.date)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Text(session.month)
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
                            Text(session.title)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                            Text("\(session.startTime) - \(session.endTime)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    Divider()
                }
            }
        }
        .padding()
        .background(Color("CustomCellBackground"))
        .cornerRadius(10)
        .padding()
    }
}

struct RaceSession: Hashable {
    let date: String
    let month: String
    let title: String
    let startTime: String
    let endTime: String
}

let raceSessions = [
    RaceSession(date: "22", month: "Mar", title: "Practice 1", startTime: "06:30", endTime: "07:30"),
    RaceSession(date: "22", month: "Mar", title: "Practice 2", startTime: "10:00", endTime: "11:30"),
    RaceSession(date: "23", month: "Mar", title: "Practice 3", startTime: "06:30", endTime: "07:30"),
    RaceSession(date: "23", month: "Mar", title: "Qualifying", startTime: "10:00", endTime: "11:00"),
    RaceSession(date: "24", month: "Mar", title: "Race", startTime: "10:00", endTime: "12:00")
]

struct RaceWeekendView_Previews: PreviewProvider {
    static var previews: some View {
        RaceWeekendView()
            .previewLayout(.sizeThatFits)
    }
}
