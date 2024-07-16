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
        CoverFlowView(
            itemWidth: 280,
            enableReflection: enableReflection,
            spacing: spacing,
            rotation: rotation,
            items: drivers
        ) { driver in
            HStack {
                Text(driver.givenName)
                    .font(.title)
                    .foregroundStyle(.white)
                VStack {
                    Image("Max", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                }
            }
            .frame(width: 340, height: 150)
            .background(Color("CustomCellBackground"))
            .cornerRadius(10)
        }
        .frame(height: 180)
    }
}
