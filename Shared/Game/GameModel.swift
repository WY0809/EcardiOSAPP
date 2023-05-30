//
//  GameModel.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/17.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    let player1: String
    var player1_deck: String
    var player1_card: String
    var player1_check: Bool
    var player1_ready: Bool
    
    let player2: String
    var player2_deck: String
    var player2_card: String
    var player2_check: Bool
    var player2_ready: Bool
    
    let roomNumber: String
    var Status: String
    var ready_check: Bool
    var round_check: Bool
    var isGameover: Bool
}

class GameModel: ObservableObject {
    @Published var round: Int = 5
    @Published var roomnumber: String = ""
    @Published var player_deck: String = "Slave"
    @Published var Status: String = ""
    @Published var GameStatus: String = "waiting"
    @Published var isPlayer2: Bool = false
    @Published var isSlave: Bool = false
    
    
    @Published var Emperor_deck1: [String] =  ["Citizen","Citizen","Emperor","Citizen","Citizen"]
    @Published var Emperor_deck2: [String] =  ["Citizen","Citizen","Emperor","Citizen","Citizen"]
    @Published var Slave_deck1: [String] =  ["Citizen","Citizen","Slave","Citizen","Citizen"]
    @Published var Slave_deck2: [String] =  ["Citizen","Citizen","Slave","Citizen","Citizen"]
    
    @Published var pick_i:Int = -1
    @Published var picking: [CGFloat] = [0,0,0,0,0]
    @Published var picking_opacity: [Double] = [1,1,1,1,1]
    @Published var mid_opacity: Double = 0
    @Published var isFaceUp: Bool = false
    @Published var player1_card:String = ""
    @Published var player2_card:String = ""
    @Published var isGameover: Bool = false
    
    
    func PickCard(i: Int){
        if(isGameover == false){
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).getDocuments{ querySnapshot, error in
                guard let querySnapshot = querySnapshot else { return }
                querySnapshot.documentChanges.forEach { documentChange in
                    guard let room = try? documentChange.document.data(as: Room.self) else { return }
                    
                    let document = querySnapshot.documents.first
                    if((user?.displayName)! == room.player1){
                        if(room.player1_deck == "Emperor"){
                            document?.reference.updateData(["player1_card": self.Emperor_deck1[i]], completion: { (error) in})
                        }else if(room.player1_deck == "Slave"){
                            document?.reference.updateData(["player1_card": self.Slave_deck1[i]], completion: { (error) in})
                        }
                    }else if((user?.displayName)! == room.player2){
                        if(room.player2_deck == "Emperor"){
                            document?.reference.updateData(["player2_card": self.Emperor_deck2[i]], completion: { (error) in})
                        }else if(room.player2_deck == "Slave"){
                            document?.reference.updateData(["player2_card": self.Slave_deck2[i]], completion: { (error) in})
                        }
                    }
                }
            }
            picking = [0,0,0,0,0]
            pick_i = i
            picking[i] = 1.5
        }
    }
    
    func Check(){
        if(isGameover == false){
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).getDocuments{ querySnapshot, error in
                guard let querySnapshot = querySnapshot else { return }
                querySnapshot.documentChanges.forEach { documentChange in
                    guard let room = try? documentChange.document.data(as: Room.self) else { return }
                    
                    let document = querySnapshot.documents.first
                    if((user?.displayName)! == room.player1){
                        if(room.player2_check){
                            switch(self.judge(player1_card: room.player1_card, player2_card: room.player2_card)){
                            case "Player1 win":
                                self.Status = "\(room.player1) win!"
                                self.isGameover = true
                            case "Player2 win":
                                self.Status = "\(room.player2) win!"
                                self.isGameover = true
                            default:
                                self.Status = "Draw"
                            }
                            document?.reference.updateData(["player2_check": false , "Status": self.Status,"round_check":true,"isGameover": self.isGameover], completion: { (error) in})
                        }else{
                            document?.reference.updateData(["player1_check": true], completion: { (error) in})
                        }
                        
                        self.picking_opacity[self.pick_i] = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.round = self.round - 1;
                            self.picking_opacity.remove(at: self.pick_i)
                            
                            
                            if(room.player1_deck == "Emperor"){
                                self.Emperor_deck1.remove(at: self.pick_i)
                            }else if(room.player1_deck == "Slave"){
                                self.Slave_deck1.remove(at: self.pick_i)
                            }
                            
                        }
                    }else if((user?.displayName)! == room.player2){
                        if(room.player1_check){
                            switch(self.judge(player1_card: room.player1_card, player2_card: room.player2_card)){
                            case "Player1 win":
                                self.Status = "\(room.player1) win!"
                                self.isGameover = true
                            case "Player2 win":
                                self.Status = "\(room.player2) win!"
                                self.isGameover = true
                            default:
                                self.Status = "Draw"
                            }
                            document?.reference.updateData(["player1_check": false , "Status": self.Status,"round_check":true,"isGameover": self.isGameover], completion: { (error) in})
                        }else{
                            document?.reference.updateData(["player2_check": true], completion: { (error) in})
                        }
                        
                        self.picking_opacity[self.pick_i] = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.round = self.round - 1;
                            self.picking_opacity.remove(at: self.pick_i)
                            
                            
                            if(room.player2_deck == "Emperor"){
                                self.Emperor_deck2.remove(at: self.pick_i)
                            }else if(room.player2_deck == "Slave"){
                                self.Slave_deck2.remove(at: self.pick_i)
                            }
                            
                        }
                    }
                }
            }
            picking = [0,0,0,0,0]
        }
    }
    
    func judge(player1_card: String , player2_card: String) -> String{
        if(player1_card == "Emperor" && player2_card == "Citizen"){
            Status = "Player1 win"
        }else if(player1_card == "Citizen" && player2_card == "Slave"){
            Status = "Player1 win"
        }else if(player1_card == "Slave" && player2_card == "Emperor"){
            Status = "Player1 win"
        }else if(player1_card == "Emperor" && player2_card == "Slave"){
            Status = "Player2 win"
        }else if(player1_card == "Citizen" && player2_card == "Emperor"){
            Status = "Player2 win"
        }else if(player1_card == "Slave" && player2_card == "Citizen"){
            Status = "Player2 win"
        }else{
            Status = "Draw"
        }
        return Status
        
    }
    
    func Onappear(){
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documentChanges.forEach { documentChange in
                guard let room = try? documentChange.document.data(as: Room.self) else { return }
                
                let document = querySnapshot.documents.first
                
                if((user?.displayName)! == room.player1){
                    self.player_deck = room.player1_deck
                }else if((user?.displayName)! == room.player2){
                    self.isPlayer2 = true
                    self.player_deck = room.player2_deck
                }
                
                if(self.player_deck == "Slave"){
                    self.isSlave = true
                }
                
                self.Status = room.Status
                
                if(room.player2 != ""){
                    self.GameStatus = "start"
                }
                
                if(room.round_check == true){
                    self.player1_card = room.player1_card
                    self.player2_card = room.player2_card
                    self.mid_opacity = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isFaceUp = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isFaceUp = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.mid_opacity = 0
                                document?.reference.updateData(["round_check":false], completion: { (error) in})
                            }
                        }
                    }
                }
                
                if(room.isGameover){
                    self.isGameover = room.isGameover
                }
            }
        }
    }
    
    func restart(){
        round = 5
        Status = ""
        Emperor_deck1 =  ["Citizen","Citizen","Emperor","Citizen","Citizen"]
        Emperor_deck2 =  ["Citizen","Citizen","Emperor","Citizen","Citizen"]
        Slave_deck1 =  ["Citizen","Citizen","Slave","Citizen","Citizen"]
        Slave_deck2 =  ["Citizen","Citizen","Slave","Citizen","Citizen"]
        pick_i = -1
        picking_opacity = [1,1,1,1,1]
        player1_card = ""
        player2_card = ""
        isGameover = false
        //let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        db.collection("Rooms").whereField("roomNumber", isEqualTo: roomnumber).getDocuments{ querySnapshot, error in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documentChanges.forEach { documentChange in
                //guard let room = try? documentChange.document.data(as: Room.self) else { return }
                
                let document = querySnapshot.documents.first
                
                document?.reference.updateData(["Status":"","player1_card":"","player2_card":"","isGameover": false], completion: { (error) in})
            }
        }
    }
}
