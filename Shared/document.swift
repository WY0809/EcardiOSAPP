//
//  document.swift
//  Final
//
//  Created by User14 on 2023/4/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Song: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let singer: String
    let rate: Int
}

struct document: View {
    
    var body: some View {
        VStack{
            Button("create"){
                createSong()
            }
        }
        
    }
    func createSong() {
        let db = Firestore.firestore()
        
        do {
            try db.collection("songs").document("陪你很久很久").setData(from: Song(name: "陪你很", singer: "小", rate: 20))
        } catch {
            print(error)
        }
    }
}

struct document_Previews: PreviewProvider {
    static var previews: some View {
        document()
    }
}
