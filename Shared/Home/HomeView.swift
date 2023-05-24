//
//  HomeView.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/12.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeModel()
    
    var body: some View {
        
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                //加一個waiting動畫
                Text("Room Number: \(viewModel.createRoomNumber)")
                TextField("Room Number", text: $viewModel.joinRoomNumber)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding()
                    .overlay(textFieldBorder)
                    .padding(.horizontal, 80)
                    .frame(width: 500, height: 60, alignment: .center)
                    .fixedSize()
                    .frame(width: 350, height: 60, alignment: .center)
                HStack{
                    Button{
                        viewModel.CreateGame()
                    }label:{
                        Text("Create a Game")
                            .font(.title3)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(40)
                            .foregroundColor(Color.red)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                            .fixedSize()
                            .frame(width: 180, height:80, alignment: .center)
                    }.fullScreenCover(isPresented: $viewModel.ShowPickDeckView1){
                        PickDeckView(roomnumber: $viewModel.createRoomNumber)
                    }
                    
                    Button{
                        viewModel.JoinGame()
                    }label:{
                        Text("Join a Game")
                            .font(.title3)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(40)
                            .foregroundColor(Color.red)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                            .fixedSize()
                            .frame(width: 180, height:80, alignment: .center)
                    }.fullScreenCover(isPresented: $viewModel.ShowPickDeckView2){
                        PickDeckView(roomnumber: $viewModel.joinRoomNumber)
                    }
                }
            }
        }
    }
    var textFieldBorder: some View{
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black,lineWidth: 3)
            .scaleEffect(x: 1, y: 1)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
