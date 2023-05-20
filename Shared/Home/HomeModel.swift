//
//  HomeModel.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/12.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift



class HomeModel: ObservableObject {
    @Published var createRoomNumber: String = "_ _ _ _ _"
    @Published var joinRoomNumber: String = ""
    @Published var ShowGameView1: Bool = false
    @Published var ShowGameView2: Bool = false
    
    func CreateGame(){
        createRoomNumber = "\(Int.random(in: 10000...99999))"
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        do {
            try db.collection("Rooms").document(createRoomNumber).setData(from: Room(roomNumber: createRoomNumber , player1: (user?.displayName)!, player2: ""))
            ShowGameView1 = true;
        } catch {
            print(error)
        }
    }
    
    func JoinGame(){
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: joinRoomNumber).getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.ShowGameView2 = true;
                let document = querySnapshot.documents.first
                document?.reference.updateData(["player2": (user?.displayName)!], completion: { (error) in
                })
            }
        }
    }
}
