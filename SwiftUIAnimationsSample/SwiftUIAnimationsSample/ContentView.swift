//
//  ContentView.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationEffect = 1.0
    
    var body: some View {
            Button("Tap me") { animationEffect += 1}
                .padding(50)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .scaleEffect(animationEffect)
                //.blur(radius: (animationEffect - 1) * 3)
                .animation(.linear, value: animationEffect)
    }
}

#Preview {
    ContentView()
}
