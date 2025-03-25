//
//  ButtonWith.swift
//  BestPixelAi
//
//  Created by Ronaldo Avalos on 20/03/25.
//

import SwiftUI

struct SubscriptionOption: View {
    @State private var shimmerOffset: CGFloat = -200
    
    let title: String
    let price: String
    let period: String
    let offer: String?
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Text(offer ?? "")
                    .foregroundStyle(Color.black)
                    .font(.caption.bold())
            }
            .padding(.horizontal,12)
            .padding(.vertical,6)
            .background(.white)
            .overlay(isSelected ? loadingOverlay() : nil)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .offset(y:-76)
            .zIndex(1)
            Button {
                action()
            } label: {
                VStack(spacing: 14 ) {
                    Text(title)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                    VStack(spacing:10){
                        Text(price)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        Text(period)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Image(systemName: "checkmark")
                            .font(.subheadline.bold())
                            .foregroundStyle( isSelected ? Color.aiPink : Color.clear)
                        
                    }
                    
                }
                .frame(width: 130,height: 160)
                .overlay(isSelected ? loadingOverlay() : nil)
                .background(
                    isSelected ? nil :
                        RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(isSelected ? .black : .gray.opacity(0.6), lineWidth: 2)
                        .mask(
                            RoundedRectangle(cornerRadius: 18)
                        )
                    
                )
                .onAppear {
                    startShimmerAnimation()
                }
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
    }
    
    private func loadingOverlay() -> some View {
        RoundedRectangle(cornerRadius: 18)
            .strokeBorder(Color.white.opacity(0.3), lineWidth: 2)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(shimmerGradient(), lineWidth: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 12)
                    )
            )
    }
    
    private func shimmerGradient() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                .aiPink,
                .neonBlue,
                .futuristicViolet,
                .aiPink
            ]),
            startPoint: UnitPoint(x: shimmerOffset / 200, y: 0),
            endPoint: UnitPoint(x: (shimmerOffset + 200) / 200, y: 0)
        )
    }
    
    private func startShimmerAnimation() {
        withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
            shimmerOffset = 200  // Mueve el brillo a la derecha
        }
    }
}


#Preview {
    SubscriptionOption(
        title: "Weekly",
        price: "$6.99",
        period: "por week",
        offer: "Save 60%",
        isSelected: false) {
            
        }
}
