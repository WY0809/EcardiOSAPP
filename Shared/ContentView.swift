//
//  ContentView.swift
//  Shared
//
//  Created by 曹文耀 on 2023/5/5.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        VStack{
            Button("Register"){
                Auth.auth().createUser(withEmail: "cind@test.com", password: "1234567") { (Result, Error) in
                    guard Error == nil else{
                        return
                    }
                    print("OK")
                }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = "帥哥"
                changeRequest?.commitChanges(completion: { error in
                    guard error == nil else {
                        print(error?.localizedDescription)
                        return
                    }
                })
            }
            Button("Check"){
                
                if let user = Auth.auth().currentUser {
                    print(user.uid, user.email, user.displayName)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
