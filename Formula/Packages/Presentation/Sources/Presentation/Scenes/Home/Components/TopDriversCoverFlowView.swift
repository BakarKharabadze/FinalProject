//
//  TopDriversCoverFlowView.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import SwiftUI
import Domain

struct TopDriversCoverFlowView: View {
    
    //MARK: - Properties
    @State private var spacing: CGFloat = 0
    @State private var rotation: CGFloat = 65
    @State private var enableReflection: Bool = false

    let drivers: [DriverEntity]
    
    //MARK: - Body
    var body: some View {
        let topDrivers = drivers.prefix(3)
        VStack {
            CoverFlowView(
                itemWidth: 280,
                enableReflection: enableReflection,
                spacing: spacing,
                rotation: rotation,
                items: Array(topDrivers)
            ) { driver in
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(driver.givenName + " " + driver.familyName)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                            
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
            }
            .frame(height: 180)
        }
    }
}

private extension View {
    func onPageChanged(_ action: @escaping (Int) -> Void) -> some View {
        self.modifier(PageChangedModifier(action: action))
    }
}

//MARK: - PageChangedModifier
struct PageChangedModifier: ViewModifier {
    let action: (Int) -> Void
    @State private var previousOffset: CGFloat = 0
    @State private var currentPage: Int = 0

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            previousOffset = proxy.frame(in: .global).minX
                        }
                        .onChange(of: proxy.frame(in: .global).minX) { newOffset in
                            let diff = newOffset - previousOffset
                            if abs(diff) > proxy.size.width / 2 {
                                previousOffset = newOffset
                                currentPage += diff > 0 ? -1 : 1
                                currentPage = max(0, min(currentPage, 2))
                                action(currentPage)
                            }
                        }
                }
            )
    }
}
