//
//  FirestoreManager.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/11/23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    
    private let db = Firestore.firestore()
    
    func saveBracket(bracket: Bracket)
    {
        
        let docRef = db.collection("Brackets").document(bracket.id)
        
        docRef.setData(bracket.toDictionaryValues()) {
            error in
            if let error = error {
                print("Error in writing document: \(error)")
            } else {
                print("Document \(bracket.name) sucessfully saved to Firestore")
            }
        }
    }
    
    func updateBracket(bracket: Bracket)
    {
        
        let docRef = db.collection("Brackets").document(bracket.id)
        
        docRef.setData(bracket.toDictionaryValues(), merge: true) {
            error in
            if let error = error {
                print("Error in updating document: \(error)")
            } else {
                print("Document \(bracket.name) sucessfully updated to Firestore")
            }
        }
        
        
    }
    
    func loadBrackets(completion: @escaping ([Bracket]) -> ())
    {
        let db = Firestore.firestore()
        
        db.collection("Brackets").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else {
                guard let snapshot = querySnapshot else { return }
                var brackets: [Bracket] = []
                for doc in snapshot.documents {
                    let foundBracket = Bracket(data: doc.data())
                    brackets.append(foundBracket)
                }
                
                brackets = brackets.sorted {
                    $0.created < $1.created
                }
                completion(brackets)
            }
        }
        // no return
        
        
    }
}
