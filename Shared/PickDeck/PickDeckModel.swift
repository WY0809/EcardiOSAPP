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
    @Published var isPlayer2: Bool = false
    @Published var Player1_deck: String = ""
    @Published var Player2_deck: String = ""
    @Published var isReady1: Bool = false
    @Published var isReady2: Bool = false
    
    let user = Auth.auth().currentUser
    
    func Ready(){
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).getDocuments{ querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documentChanges.forEach { documentChange in
                guard let room = try? documentChange.document.data(as: Room.self) else { return }
                
                let document = querySnapshot.documents.first
                if((user?.displayName)! == room.player1 && room.player1_deck != ""){
                    if(room.player2_ready){
                        if(room.player1_deck != room.player2_deck){
                            document?.reference.updateData(["player2_ready": false,"ready_check": true], completion: { (error) in})
                        }
                    }else if(!room.player1_ready){
                        document?.reference.updateData(["player1_ready": true], completion: { (error) in})
                    }else{
                        document?.reference.updateData(["player1_ready": false], completion: { (error) in})
                    }
                }else if((user?.displayName)! == room.player2 && room.player2_deck != ""){
                    if(room.player1_ready){
                        if(room.player1_deck != room.player2_deck){
                            document?.reference.updateData(["player1_ready": false,"ready_check": true], completion: { (error) in})
                        }
                    }else if(!room.player2_ready){
                        document?.reference.updateData(["player2_ready": true], completion: { (error) in})
                    }else{
                        document?.reference.updateData(["player2_ready": false], completion: { (error) in})
                    }
                }
            }
        }
    }
    
    func Onappear(){
//        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documentChanges.forEach { documentChange in
                guard let room = try? documentChange.document.data(as: Room.self) else { return }

                if(room.player2 != ""){
                    self.isPlayer2 = true
                }
                self.Player1_deck = room.player1_deck
                self.Player2_deck = room.player2_deck
                
                self.isReady1 = room.player1_ready
                self.isReady2 = room.player2_ready
                
                if(room.ready_check){
                    self.ShowGameView = true
                }
            }
        }
    }
    
    func PickDeck(Deck: String){
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).getDocuments{ querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documentChanges.forEach { documentChange in
                guard let room = try? documentChange.document.data(as: Room.self) else { return }
                
                let document = querySnapshot.documents.first
                
                if((user?.displayName)! == room.player1){
                    document?.reference.updateData(["player1_deck": Deck], completion: { (error) in})
                }else if((user?.displayName)! == room.player2){
                    document?.reference.updateData(["player2_deck": Deck], completion: { (error) in})
                }
            }
        }
    }
}
