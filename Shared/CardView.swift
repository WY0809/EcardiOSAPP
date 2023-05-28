//
//  CardView.swift
//  Demo
//
//  Created by Peter Pan on 2023/5/9.
//

import SwiftUI

struct CardView: View {
    let cardImage: Image
    let cardBackImage: Image
    @Binding var isFaceUp: Bool

    var body: some View {
        let cardWidth: CGFloat = UIScreen.main.bounds.height*11/60
        let cardHeight: CGFloat = UIScreen.main.bounds.height/4

        ZStack {
            cardImage
                .resizable()
                .frame(width: cardWidth, height: cardHeight)
                .opacity(isFaceUp ? 1 : 0)
            cardBackImage
                .resizable()
                .frame(width: cardWidth, height: cardHeight)
                .rotationEffect(.degrees(180))
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(isFaceUp ? 0 : 180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        //.animation(.linear(duration: 5), value: isFaceUp)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: isFaceUp)
        .onTapGesture {
            withAnimation {
                //isFaceUp.toggle()
            }
        }
    }
}

//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
