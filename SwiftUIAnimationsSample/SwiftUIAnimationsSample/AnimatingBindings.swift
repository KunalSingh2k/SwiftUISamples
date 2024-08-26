//
//  AnimatingBindings.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct AnimatingBindings: View {
    @State private var animationEffect = 1.0
    
    var body: some View {
        print(animationEffect)
        return VStack {
            Stepper("Scale amount", value: $animationEffect.animation(), in: 1...10)
            Spacer()
            
            Button("Tap Me") {
                animationEffect += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationEffect)
        }
        .padding()
    }
}

#Preview {
    AnimatingBindings()
}
