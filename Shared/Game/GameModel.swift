//
//  GameModel.swift
//  E-card
//
//  Created by 曹文耀 on 2023/5/17.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Room: Codable, Identifiable {
    @DocumentID var id: String?
    let roomNumber: String
    let player1: String
    let player2: String
}

class GameModel: ObservableObject {
    @Published var round: Int = 5
    @Published var player_deck: String = "Slave"
    @Published var player2_deck: String = "Slave"
    @Published var Emperor_deck: [String] =  ["Citizen","Citizen","Emperor","Citizen","Citizen"]
    @Published var Slave_deck: [String] =  ["Citizen","Citizen","Slave","Citizen","Citizen"]
    
    func play(i: Int){
        round = round - 1;
        if(player_deck == "Emperor"){
            Emperor_deck.remove(at: i)
        }else if(player_deck == "Slave"){
            Slave_deck.remove(at: i)
        }
    }
}
