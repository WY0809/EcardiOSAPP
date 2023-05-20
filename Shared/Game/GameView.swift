//
//  GameView.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/13.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameModel()
    @Binding var roomnumber: String
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("roomnumber:\(roomnumber)")
//                Button("check"){
//                    print(roomnumber)
//                }
                HStack{
                    ForEach(0...viewModel.round-1, id: \.self){ i in
                        Image("Back")
                            .resizable()
                            .frame(width: 88, height:120, alignment: .center)
                            .fixedSize()
                    }
                }
                
                HStack{
                    if(viewModel.player_deck == "Emperor"){
                        ForEach(0...viewModel.round-1, id: \.self){ i in
                            Button{
                                viewModel.play(i: i)
                            }label:{
                                Image(viewModel.Emperor_deck[i])
                                    .resizable()
                                    .frame(width: 88, height:120, alignment: .center)
                                    .fixedSize()
                            }
                        }
                    }else if(viewModel.player_deck == "Slave"){
                        ForEach(0...viewModel.round-1, id: \.self){ i in
                            Button{
                                viewModel.play(i: i)
                            }label:{
                                Image(viewModel.Slave_deck[i])
                                    .resizable()
                                    .frame(width: 88, height:120, alignment: .center)
                                    .fixedSize()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    struct GameViewDemo: View {
        @StateObject private var viewModel = GameModel()
        @State private var roomnumber = "12345"
        var body: some View {
            ZStack{
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Text("roomnumber:\(roomnumber)")
                    HStack{
                        ForEach(0...viewModel.round-1, id: \.self){ i in
                            Image("Back")
                                .resizable()
                                .frame(width: 88, height:120, alignment: .center)
                                .fixedSize()
                        }
                    }
                    //ProgressView(value: 1)//做倒計時動畫
                    HStack{
                        if(viewModel.player_deck == "Emperor"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.play(i: i)
                                }label:{
                                    Image(viewModel.Emperor_deck[i])
                                        .resizable()
                                        .frame(width: 88, height:120, alignment: .center)
                                        .fixedSize()
                                }
                            }
                        }else if(viewModel.player_deck == "Slave"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.play(i: i)
                                }label:{
                                    Image(viewModel.Slave_deck[i])
                                        .resizable()
                                        .frame(width: 88, height:120, alignment: .center)
                                        .fixedSize()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    static var previews: some View {
        GameViewDemo()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
