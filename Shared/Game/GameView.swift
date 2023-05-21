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
            HStack(alignment: .center, spacing: 30){
                VStack{
                    Text("roomnumber:\(roomnumber)")
                    HStack{
                        ForEach(0...viewModel.round-1, id: \.self){ i in
                            Image("Back")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                .fixedSize()
                        }
                    }
                    ZStack{
                        Text("Status:\(viewModel.Status)")
                        HStack(alignment: .center, spacing: UIScreen.main.bounds.height*11/60*3.5){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                    .opacity(0.6)
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: UIScreen.main.bounds.height*11/60*7/8, height:UIScreen.main.bounds.height/4*7/8, alignment: .center)
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                
                            }
                            
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
                    //ProgressView(value: 1)//做倒計時動畫
                    HStack{
                        if(viewModel.player_deck == "Emperor"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.PickCard(i: i)
                                }label:{
                                    Image(viewModel.Emperor_deck[i])
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                        .fixedSize()
                                }
                            }
                        }else if(viewModel.player_deck == "Slave"){
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Button{
                                    viewModel.PickCard(i: i)
                                }label:{
                                    Image(viewModel.Slave_deck[i])
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                        .fixedSize()
                                }
                            }
                        }
                    }
                }
                Button{
                    viewModel.Check()
                }label:{
                    Text("✅")
                        .font(.largeTitle)
                }
                
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
        @StateObject private var viewModel = GameModel()
        @State private var roomnumber = "12345"
        var body: some View {
            ZStack{
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                HStack(alignment: .center, spacing: 30){
                    VStack{
                        Text("roomnumber:\(roomnumber)")
                        HStack{
                            ForEach(0...viewModel.round-1, id: \.self){ i in
                                Image("Back")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                    .fixedSize()
                            }
                        }
                        ZStack{
                            Text("Status:\(viewModel.Status)")
                            HStack(alignment: .center, spacing: UIScreen.main.bounds.height*11/60*3.5){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                        .opacity(0.6)
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: UIScreen.main.bounds.height*11/60*7/8, height:UIScreen.main.bounds.height/4*7/8, alignment: .center)
                                        .foregroundColor(.white)
                                        .opacity(0.5)
                                    
                                }
                                
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
                        //ProgressView(value: 1)//做倒計時動畫
                        HStack{
                            if(viewModel.player_deck == "Emperor"){
                                ForEach(0...viewModel.round-1, id: \.self){ i in
                                    Button{
                                        viewModel.PickCard(i: i)
                                    }label:{
                                        Image(viewModel.Emperor_deck[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                    }
                                }
                            }else if(viewModel.player_deck == "Slave"){
                                ForEach(0...viewModel.round-1, id: \.self){ i in
                                    Button{
                                        viewModel.PickCard(i: i)
                                    }label:{
                                        Image(viewModel.Slave_deck[i])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.height*11/60, height:UIScreen.main.bounds.height/4, alignment: .center)
                                            .fixedSize()
                                    }
                                }
                            }
                        }
                    }
                    Button{
                        viewModel.Check()
                    }label:{
                        Text("✅")
                            .font(.largeTitle)
                    }
                    
                }
                
            }
            .onAppear {
                viewModel.roomnumber = roomnumber
                viewModel.Onappear()
            }
        }
    }
    static var previews: some View {
        GameViewDemo()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
