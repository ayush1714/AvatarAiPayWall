//
//  Paywall.swift
//  AvatarAiPayWall
//
//  Created by Ronaldo Avalos on 24/03/25.
//

import SwiftUI

struct Paywall: View {
    @State private var selectedSubscription: String? = "weekly"
    @State private var isLoading: Bool = false
    
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        VStack {
            ZStack {
                CarouselCards()
                BackgroundGradiant()
                VStack {
                    Spacer()
                    HeroView()
                        .padding(.vertical,42)
                        .padding(.horizontal,24)
                    Spacer()
                    VStack(spacing: 54) {
                        SupscriptionsOptionsView()
                        FooterView()
                    }
                }.padding(.bottom)
                if isLoading {
                    Rectangle().fill(.black.opacity(0.8))
                        .overlay {
                            VStack {
                                Spacer()
                                ProgressView()
                                    .tint(.white)
                                Spacer()
                            }
                        }
                }
            }
            .onChange(of:isLoading) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isLoading = false
                }
            }
            .ignoresSafeArea()
           
        }
    }
    
    
    @ViewBuilder
    func HeroView() -> some View {
        VStack {
            Spacer()
            Text("Artify")
                .foregroundStyle(Color.mintGreen)
                .font(.system(.largeTitle,design: .serif ,weight: .bold))
                .multilineTextAlignment(.center)
            Text("Avatar Generator")
                .foregroundStyle(Color.white)
                .font(.system(.largeTitle, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text("Unlock all features, including unlimited access to Avatar, personalized themes!")
                .foregroundStyle(Color.gray)
                .font(.system(.subheadline))
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    func SupscriptionsOptionsView() -> some View {
        HStack(spacing:24) {
            SubscriptionOption(
                title: "Weekly",
                price: "$6.99",
                period: "por week",
                offer: "popular",
                isSelected: selectedSubscription == "weekly") {
                    selectedSubscription = "weekly"
                }
            
            
            SubscriptionOption(
                title: "Annual",
                price: "$49.99",
                period: "por annual",
                offer: "Save 63%",
                isSelected: selectedSubscription == "annual") {
                    selectedSubscription = "annual"
                }
            
        }
    }
    
    @ViewBuilder
    func FooterView() -> some View {
        VStack {
            Button {
                isLoading = true
            } label: {
                Text("Contiune")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(height: 64)
                    .frame(maxWidth: .infinity)
                    .background(Color.roboticBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal,32)
                
            }
            Text("Recurring billing, cancel anytime")
                .font(.subheadline.bold())
                .padding(6)
            
            Text("By tapping 'Continue', you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store Settings, and you agree to our")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.secondary)
                .padding(.horizontal)
                .padding(.bottom,2)
            HStack(spacing: 14) {
                Button(action: {}) {Text("Terms").foregroundStyle(Color.white)}
                Text("|").foregroundStyle(Color.white)
                Button(action: {}) { Text("Privacy").foregroundStyle(Color.white) }
                Text("|").foregroundStyle(Color.white)
                Button(action: {}) { Text("Restore").foregroundStyle(Color.white) }
            }
            .font(.footnote)
            .foregroundColor(.blue)
        }
        
    }
    
    @ViewBuilder
    func CarouselCards() -> some View {
        let imageNames1 = (15...20).map { String($0) }
        let imageNames2 = (8...14).map { String($0) }
        let imageNames3 = (1...7).map { String($0) }
        
        VStack {
            
            InfiniteCarouselView(imageNames: imageNames1, velocity: 0.5)
            InfiniteCarouselView(imageNames: imageNames2, velocity: -0.25)
            InfiniteCarouselView(imageNames: imageNames3, velocity: 0.3)
            Spacer()
        }
        .rotationEffect(.degrees(-10))
    }
    
    @ViewBuilder
    func BackgroundGradiant() -> some View {
        VStack {
            ///Grafiant
            LinearGradient(colors: [
                .clear,
                .black.opacity(0.9),
                .black,
            ], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        
        
    }
}

#Preview {
    ContentView()
}
