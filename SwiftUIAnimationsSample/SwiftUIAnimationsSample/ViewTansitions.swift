//
//  ViewTansitions.swift
//  SwiftUIAnimationsSample
//
//  Created by Kunal Kumar R on 21/08/24.
//

import SwiftUI

struct ViewTansitions: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    ViewTansitions()
}
