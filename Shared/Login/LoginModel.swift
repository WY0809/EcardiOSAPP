//
//  LoginModel.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/12.
//

import Foundation
import Firebase
class LoginModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var ShowHomeView: Bool = false
    
    
    func Signup() {
        Auth.auth().createUser(withEmail: email, password: password) { [self] (Result, Error) in
            guard Error == nil else{
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.username
            changeRequest?.commitChanges(completion: { error in
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
            })
            
            print("OK")
        }
        ShowHomeView = true
    }
    
    func Login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            print("success")
            self.ShowHomeView = true
        }
        
    }
}
