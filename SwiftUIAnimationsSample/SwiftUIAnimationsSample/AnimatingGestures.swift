//
//  AnimatingGestures.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct AnimatingGestures: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { number in
                Text(String(letters[number]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue: .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(number) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragAmount = $0.translation })
                .onEnded({ _ in 
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
    }
}

#Preview {
    AnimatingGestures()
}
