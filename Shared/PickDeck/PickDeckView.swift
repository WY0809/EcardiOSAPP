//
//  PickDeckView.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/22.
//

import SwiftUI

struct PickDeckView: View {
    @StateObject private var viewModel = PickDeckModel()
    @Binding var roomnumber: String
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Room Number: \(roomnumber)")
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                            .foregroundColor(.black)
                            .border(Color.black, width: 3)
                            .opacity(0.6)
                        Image("BlackPeople")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                        if(viewModel.SelectDeck == "Emperor"){
                            Image("Tonegawa")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                        }else if(viewModel.SelectDeck == "Slave"){
                            Image("Kaise")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                        }
                    }
                    Image("VS")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                        .opacity(viewModel.opacity)//animation
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                            .foregroundColor(.black)
                            .border(Color.black, width: 3)
                            .opacity(0.6)
                        LoadingView()
//                        Image("BlackPeople")
//                            .resizable()
//                            .frame(width: UIScreen.main.bounds.height*11/60*1.5, height:UIScreen.main.bounds.height/4*1.5)
                        
                    }
                }
                Picker(selection: $viewModel.SelectDeck) {
                    Text("Emperor").tag("Emperor")
                        .foregroundColor(.blue)
                    Text("Slave").tag("Slave")
                        .foregroundColor(.white)
                } label: {
                    Text("選擇牌組")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.main.bounds.height*11/60*5, height:30)
                
                
                
                Button {
                    viewModel.Ready()
                } label: {
                    Text("Ready  ")
                        .font(.headline)
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
                        .frame(width: 120, height:80, alignment: .center)
                }.fullScreenCover(isPresented: $viewModel.ShowGameView){
                    GameView(roomnumber: $roomnumber)
                }
                
                //Slider(value: $opacit)
            }
        }
        .onAppear {
            viewModel.roomnumber = roomnumber
        }
    }
}

struct PickDeckView_Previews: PreviewProvider {
    struct PickDeckView_Demo: View {
        @State private var a = "12345"
        var body: some View {
            PickDeckView(roomnumber: $a)
        }
        
    }
    
    static var previews: some View {
        PickDeckView_Demo()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
