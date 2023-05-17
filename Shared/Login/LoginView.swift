//
//  SwiftUIView.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/5.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject private var viewModel = LoginModel()
    @State private var check = "check"
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            HStack{
                VStack{
                    TextField("Email", text: $viewModel.email)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding()
                        .overlay(textFieldBorder)
                        .padding(.horizontal, 80)
                        .frame(width: 500, height: 60, alignment: .center)
                        .fixedSize()
                        .frame(width: 350, height: 60, alignment: .center)
                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding()
                        .overlay(textFieldBorder)
                        .padding(.horizontal, 80)
                        .frame(width: 500, height: 60, alignment: .center)
                        .fixedSize()
                        .frame(width: 350, height: 60, alignment: .center)
                    TextField("Username（註冊必填）", text: $viewModel.username)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding()
                        .overlay(textFieldBorder)
                        .padding(.horizontal, 80)
                        .frame(width: 500, height: 60, alignment: .center)
                        .fixedSize()
                        .frame(width: 350, height: 60, alignment: .center)
                }
                VStack(alignment: .center, spacing: 30){
                    Button("Login"){
                        viewModel.Login()
                    }.fullScreenCover(isPresented: $viewModel.ShowHomeView){
                        HomeView()
                    }
                    
                    Button("Sign up"){
                        viewModel.Signup()
                    }.fullScreenCover(isPresented: $viewModel.ShowHomeView){
                        HomeView()
                    }
                    
                    Button(check){
                        if let user = Auth.auth().currentUser {
                            check = "\(user.displayName) login"
                            print("\(user.uid),\(user.displayName) login")
                        } else {
                            check = "not login"
                            print("not login")
                        }
                    }
                    
                    Button("signout"){
                        do {
                            try Auth.auth().signOut()
                        } catch {
                            print(error)
                        }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
