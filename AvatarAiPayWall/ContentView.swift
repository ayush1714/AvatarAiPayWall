//
//  ContentView.swift
//  AvatarAiPayWall
//
//  Created by Ronaldo Avalos on 24/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { g in
            let safeArea = g.safeAreaInsets
            let size = g.size
            Paywall(
                safeArea:safeArea,
                size: size)
        }
    }
}

#Preview {
    ContentView()
}
