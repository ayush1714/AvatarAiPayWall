//
//  InfiniteCarouselView.swift
//  virtualStaging
//
//  Created by Ronaldo Avalos on 18/03/25.
//

import SwiftUI

struct Item : Identifiable {
    let id : UUID
    let imageName: String
}

struct InfiniteCarouselView: View {
    
    init(imageNames: [String], velocity: CGFloat = 0.3) {
        self.imageNames = imageNames
        
        var items : [Item] = []
        items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
        items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
        items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
        self.items = items
        self.velocity = velocity
        
        let length = (CarouselCard.itemSize.width + itemSpacing) * CGFloat(imageNames.count)
        self.x = length
        self.carouselLength = length
        
    }
    
    private let imageNames: [String]
    private let items: [Item]
    private let velocity: CGFloat
    @State private var x: CGFloat
    private let carouselLength: CGFloat
    private let itemSpacing : CGFloat = 8
    
    @State private var scrollPosition = ScrollPosition()
    @State private var timer = Timer
        .publish(every: 0.01, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: itemSpacing ) {
                ForEach(items) { item in
                    CarouselCard(imageName: item.imageName)
                        .id(item.id)
                }
            } // Hstack
            .safeAreaPadding(.horizontal)
        } // Scroll
        .scrollClipDisabled()
        .scrollPosition($scrollPosition)
        .onReceive(timer) { _ in
            if x >= carouselLength * 2 || x <= 0 {
                x = carouselLength
            } else {
                x += velocity
            }
        }
        .onChange(of: x) {
            scrollPosition.scrollTo(x: x)
        }
        .onScrollPhaseChange { oldPhase, newPhase in
            
            switch (oldPhase, newPhase) {
                
            case (.idle, .idle):
                break
                
            case (_, .interacting):
                timer.upstream.connect().cancel()
                
            case (_, .idle) :
                timer = Timer
                    .publish(every: 0.01, on: .main, in: .common)
                    .autoconnect()
            default:
                break
            }
        }
        
        .onScrollGeometryChange(for: Double.self) { scrollGeometry in
            scrollGeometry.contentOffset.x
        } action: { oldValue, newValue in
            x = newValue
        }

    }
    
    
}

#Preview {
    let imageNames = (1...7).map { (String($0)) }
    InfiniteCarouselView(imageNames: imageNames)
        
}
