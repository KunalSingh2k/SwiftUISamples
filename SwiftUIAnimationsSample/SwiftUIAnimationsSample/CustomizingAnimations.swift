//
//  CustomizingAnimations.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct CustomizingAnimations: View {
    @State private var animationEffect = 1.0
    
    var body: some View {
        Button("Tap me") { //animationEffect += 1
        }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            //.scaleEffect(animationEffect)
            //.animation(.linear, value: animationEffect)
            //.animation(.spring(duration: 1, bounce: 0.7), value: animationEffect)
            //.animation(.easeInOut(duration: 2).delay(0.2), value: animationEffect)
            //.animation(.easeInOut(duration: 2).repeatCount(3, autoreverses: true), value: animationEffect)
            .overlay {
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationEffect)
                    .opacity(2 - animationEffect)
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: animationEffect)
            }
            .onAppear { animationEffect = 2 }
        
    }
}

#Preview {
    CustomizingAnimations()
}
