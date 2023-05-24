//
//  PickDeckModel.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class PickDeckModel: ObservableObject {
    @Published var SelectDeck: String = ""
    @Published var opacity: Double = 1.0
    @Published var ShowGameView: Bool = false
    @Published var roomnumber: String = ""
    
    let user = Auth.auth().currentUser
    func Ready(){
        ShowGameView = true
    }
    
//    func Onappear(){
//        let user = Auth.auth().currentUser
//        let db = Firestore.firestore()
//        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).addSnapshotListener { querySnapshot, error in
//            guard let querySnapshot = querySnapshot else { return }
//            querySnapshot.documentChanges.forEach { documentChange in
//                guard let room = try? documentChange.document.data(as: Room.self) else { return }
//
//                self.roomnumber = room.roomNumber
//                if((user?.displayName)! == room.player1){
//                    self.player_deck = room.player1_deck
//                }else if((user?.displayName)! == room.player2){
//                    self.player_deck = room.player2_deck
//                }
//                self.Status = room.Status
//
//                if(room.player2 != ""){
//                    self.GameStatus = "start"
//                }
//            }
//        }
//    }
}
