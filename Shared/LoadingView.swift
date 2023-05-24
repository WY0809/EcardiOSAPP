//
//  LoadingView.swift
//  LoadingView
//
//  Created by David Kababyan on 07/08/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
