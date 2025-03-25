//
//  CarouselCard.swift
//  virtualStaging
//
//  Created by Ronaldo Avalos on 18/03/25.
//

import SwiftUI

struct CarouselCard: View {
    
    let imageName: String
    
    static let itemSize = CGSize(width:  154, height: 154)
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: CarouselCard.itemSize.width, height: CarouselCard.itemSize.height)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    CarouselCard(imageName: "1")
}
