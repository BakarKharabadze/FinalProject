//
//  PastFirstRace.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import SwiftUI
import Domain

struct PastFirstRace: View {
    
    // MARK: - Properties
    let raceResult: RaceResultEntity

    // MARK: - Body
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("CustomCellBackground"))
                .frame(width: 350, height: 260)
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
               
                Components(raceResult: raceResult)
                
                HStack(spacing: 50) {
                    FirstPlace(raceResult: raceResult)
                    SecondPlace(raceResult: raceResult)
                    ThirdPlace(raceResult: raceResult)
                }
                .padding(.top, -30)
                .padding(.leading, 30)
            }
            .padding()
        }
    }
}

struct Components: View {
    let raceResult: RaceResultEntity
    
    var body: some View {
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
    }
}

struct FirstPlace: View {
    let raceResult: RaceResultEntity
    var body: some View {
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
    }
}

struct SecondPlace: View {
    let raceResult: RaceResultEntity
    var body: some View {
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
    }
}
struct ThirdPlace: View {
    let raceResult: RaceResultEntity
    var body: some View {
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
}
