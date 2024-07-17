//
//  SwiftUIView.swift
//  
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import SwiftUI
import Domain

struct TopDriversCoverFlowView: View {
    @State private var spacing: CGFloat = 0
    @State private var rotation: CGFloat = 65
    @State private var enableReflection: Bool = false
    let drivers: [DriverEntity]
    
    var body: some View {
        let topDrivers = drivers.prefix(3)
        CoverFlowView(
            itemWidth: 280,
            enableReflection: enableReflection,
            spacing: spacing,
            rotation: rotation,
            items: Array(topDrivers)
        ) { driver in
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(driver.givenName + " " + driver.familyName)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .bold()
                        
                        if let position = Int(driver.position), position <= 3 {
                            Image("\(position)", bundle: .module)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .offset(x: 10, y: -30)
                        }
                    }
                    
                    Text(driver.constructorName)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Text("\(driver.points)")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("PTS")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
                Image(driver.givenName, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(.trailing, 15)
            }
            .frame(width: 340, height: 150)
            .background(Color("CustomCellBackground"))
            .cornerRadius(10)
        }
        .frame(height: 180)
    }
}
