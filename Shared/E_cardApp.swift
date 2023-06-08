//
//  E_cardApp.swift
//  Shared
//
//  Created by 曹文耀 on 2023/5/5.
//

import SwiftUI
import Firebase
import AVFoundation

@main
struct E_cardApp: App {
    init(){
        FirebaseApp.configure()
        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.play()
    }
    
    @State private var roomnumber = "12345"
    var body: some Scene {
        WindowGroup {
            LoginView()
            //HomeView()
            //PickDeckView()
            //GameView(roomnumber: $roomnumber)
        }
    }
}
