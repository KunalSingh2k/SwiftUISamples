//
//  ExplicitAnimations.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ExplicitAnimations: View {
    @State private var animationEffect = 0.0
    
    var body: some View {
        Button("Tap me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationEffect += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationEffect), axis: (x: 1, y:0, z: 0)
        )
    }
}

#Preview {
    ExplicitAnimations()
}
