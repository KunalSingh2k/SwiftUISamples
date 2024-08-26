//
//  EmojiRatingView.swift
//  SwiftUIBookWorm
//
//  Created by Kunal Kumar R on 23/08/24.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        case 5:
            Text("5")
        default:
            Text("1")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
