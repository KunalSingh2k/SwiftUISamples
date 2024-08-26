//
//  ControllingAnimationStack.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ControllingAnimationStack: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .red: .blue)
        .animation(.default, value: enabled)
        .foregroundStyle(.white)
//      .clipShape(.circle)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
        
    }
}

#Preview {
    ControllingAnimationStack()
}
