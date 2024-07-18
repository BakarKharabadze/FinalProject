//
//  DriverDetailsSwiftUIView.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import SwiftUI

struct DriverDetailsSwiftUIView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            horizontalLabel(labelText: "Races:", valueText: "196")
            horizontalLabel(labelText: "World Titles:", valueText: "3")
            horizontalLabel(labelText: "Race Wins:", valueText: "61")
            horizontalLabel(labelText: "Podiums:", valueText: "106")
            horizontalLabel(labelText: "Nationality:", valueText: "Netherlands")
            horizontalLabel(labelText: "Birthday:", valueText: "1997-09-30")
            horizontalLabel(labelText: "Birth Place:", valueText: "Hasselt, Belgium")
        }
        .frame(width: 300)
        .padding()
        .background(Color("CustomBackground"))
        .cornerRadius(10)
    }
    
    private func horizontalLabel(labelText: String, valueText: String) -> some View {
        HStack {
            Text(labelText)
                .font(.system(size: 16))
                .foregroundColor(.gray)
            Spacer()
            Text(valueText)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .bold()
                .padding()
        }
    }
}

struct DriverDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DriverDetailsSwiftUIView()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
            .cornerRadius(10)
    }
}
