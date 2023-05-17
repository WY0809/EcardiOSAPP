//
//  E_cardApp.swift
//  Shared
//
//  Created by 曹文耀 on 2023/5/5.
//

import SwiftUI
import Firebase

@main
struct E_cardApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
