////
////  test.swift
////  E-card
////
////  Created by 曹文耀 on 2023/5/21.
////
//
//import Foundation
//
//// method 1
//struct Singer: Codable, Identifiable {
//    @DocumentID var id: String?
//    let name: String
//    //存專輯名字
//    let albums: [String]
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//
//            Button("check Taylor Swift") {
//                checkTaylorSwift()
//            }
//
//        }
//        .padding()
//
//    }
//
//    func checkTaylorSwift() {
//        let db = Firestore.firestore()
//        db.collection("singers").whereField("name", isEqualTo: "Taylor Swift").addSnapshotListener { snapshot, error in
//            guard let snapshot else { return }
//            snapshot.documentChanges.forEach { documentChange in
//                guard let singer = try? documentChange.document.data(as: Singer.self) else { return }
//                switch documentChange.type {
//                case .added:
//                    print("add", singer)
//                case .modified:
//                    print("modified", singer)
//                case .removed:
//                    print("removed", singer)
//                }
//            }
//        }
//    }
//}
