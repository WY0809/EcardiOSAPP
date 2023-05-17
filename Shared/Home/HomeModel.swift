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

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    let RoomNumber: String
    let player1: String
    let player2: String
    var number: Int
}

class HomeModel: ObservableObject {
    @Published var createRoomNumber: String = "_ _ _ _ _"
    @Published var joinRoomNumber: String = ""
    @Published var num: Int = 1
    @Published var ShowGameView: Bool = false
    
    func CreateGame(){
        createRoomNumber = "\(Int.random(in: 10000...99999))"
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        do {
            try db.collection("Rooms").document(createRoomNumber).setData(from: Room(RoomNumber: createRoomNumber ,player1: (user?.displayName)!, player2: "", number: 0))
            ShowGameView = true;
        } catch {
            print(error)
        }
        
        
        //        db.collection("Rooms").whereField("RoomNumber", isEqualTo: createRoomNumber).getDocuments { snapshot, error in
        //            guard let snapshot 	else { return }
        //            if snapshot.documents.isEmpty  {
        //                print(1)
        //            } else {
        //                print(2)
        //            }
        //        }
    }
    
    func JoinGame(){
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let documentReference = db.collection("Rooms").document(joinRoomNumber)
//        documentReference.getDocument { document, error in
//
//            guard let document,
//                  document.exists,
//                  var room = try? document.data(as: Room.self)
//            else {
//                return
//            }
//            room.player2 = user.displayName
//            do {
//                try documentReference.setData(from: room)
//                ShowGameView = true
//            } catch {
//                print(error)
//            }
//
//        }
    }
    
}
