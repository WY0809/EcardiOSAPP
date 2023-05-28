//
//  GameView.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/13.
//

import SwiftUI



struct GameView: View {
    @StateObject private var viewModel = GameModel()
    @State private var isFaceUp = false
    @Binding var roomnumber: String
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            HStack(alignment: .center, spacing: 30){
                VStack{
                    Text("Room Number: \(viewModel.roomnumber)")
                    HStack{
                        ForEach(0...viewModel.round-1, id: \.self){ i in
                            Image("Back")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                .fixedSize()
                                .opacity(viewModel.picking_opacity[i])
                                .animation(.default, value: viewModel.picking_opacity[i])
                        }
                    }
                    ZStack{
                        Text("Status : \(viewModel.Status)")
                        HStack(alignment: .center, spacing: UIScreen.main.bounds.height*11/60*3.5){
                            ZStack{
                                CardAreaView()
                                CardView(cardImage: Image(viewModel.player1_card), cardBackImage: Image("Back"), isFaceUp: $viewModel.isFaceUp)
                                    .opacity(viewModel.mid_opacity)
                                    .animation(.default, value: viewModel.mid_opacity)
                            }
                            ZStack{
                                CardAreaView()
                                CardView(cardImage: Image(viewModel.player2_card), cardBackImage: Image("Back"), isFaceUp: $viewModel.isFaceUp)
                                    .opacity(viewModel.mid_opacity)
                                    .animation(.default, value: viewModel.mid_opacity)
                            }
                        }
                    }
                    //ProgressView(value: 1)//做倒計時動畫
                    HStack{
                        if(viewModel.player_deck == "Emperor"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.PickCard(i: i)
                                }label:{
                                    if(viewModel.isPlayer2){
                                        Image(viewModel.Emperor_deck2[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                            .border(Color.red, width: viewModel.picking[i])
                                            .opacity(viewModel.picking_opacity[i])
                                            .animation(.default, value: viewModel.picking_opacity[i])
                                    }else{
                                        Image(viewModel.Emperor_deck1[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                            .border(Color.red, width: viewModel.picking[i])
                                            .opacity(viewModel.picking_opacity[i])
                                            .animation(.default, value: viewModel.picking_opacity[i])
                                    }
                                }
                            }
                        }else if(viewModel.player_deck == "Slave"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.PickCard(i: i)
                                }label:{
                                    if(viewModel.isPlayer2){
                                        Image(viewModel.Slave_deck2[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                            .border(Color.red, width: viewModel.picking[i])
                                            .opacity(viewModel.picking_opacity[i])
                                            .animation(.default, value: viewModel.picking_opacity[i])
                                            
                                    }else{
                                        Image(viewModel.Slave_deck1[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                            .border(Color.red, width: viewModel.picking[i])
                                            .opacity(viewModel.picking_opacity[i])
                                            .animation(.default, value: viewModel.picking_opacity[i])
                                    }
                                }
                            }
                        }
                    }
                }
                VStack(alignment: .center, spacing: 100){
                    Button{
                        viewModel.Check()
                    }label:{
                        Text("✅✅✅")
                            .font(.largeTitle)
                    }
                    Button{
                        viewModel.restart()
                    }label:{
                        Text("🔄🔄🔄")
                            .font(.largeTitle)
                    }
                }
                .offset(x: 10, y: 50)
            }
            
        }
        .onAppear {
            viewModel.roomnumber = roomnumber
            viewModel.Onappear()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    struct GameViewDemo: View {
        @State private var roomnumber = "12345"
        var body: some View {
            GameView(roomnumber: $roomnumber)
        }
    }
    static var previews: some View {
        GameViewDemo()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

struct CardAreaView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                .opacity(0.6)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.height*11/60*7/8, height:UIScreen.main.bounds.height/4*7/8, alignment: .center)
                .foregroundColor(.white)
                .opacity(0.5)
            
        }
    }
}
