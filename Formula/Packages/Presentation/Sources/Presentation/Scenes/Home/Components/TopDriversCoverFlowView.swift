import SwiftUI
import Domain

struct TopDriversCoverFlowView: View {
    
    //MARK: - Properties
    @State private var spacing: CGFloat = 0
    @State private var rotation: CGFloat = 65
    @State private var enableReflection: Bool = false
    @State private var currentPage: Int = 0

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
                                .padding(.top, 10) // Adjust padding as needed
                            
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
                    
                    if let position = Int(driver.position), position <= 3 {
                        Text(positionString(for: position))
                            .font(.varsity(.regular, size: 20))
                            .foregroundColor(.white)
                            .position(x: 170, y: 30) // Adjust position as needed
                    }
                }
            }
            .frame(height: 180)
            .onPageChanged { newPage in
                currentPage = newPage
            }

            PageControl(numberOfPages: topDrivers.count, currentPage: $currentPage)
                .padding(.top, -20)
                
        }
        .onAppear {
            VarsityFont.registerFonts()
        }
    }
    
    private func positionString(for position: Int) -> String {
        switch position {
        case 1:
            return "01"
        case 2:
            return "02"
        case 3:
            return "03"
        default:
            return ""
        }
    }
}

private extension View {
    func onPageChanged(_ action: @escaping (Int) -> Void) -> some View {
        self.modifier(PageChangedModifier(action: action))
    }
}

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
