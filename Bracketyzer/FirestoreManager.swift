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
    
    func addTeamToBracket(team: Team, bracket: Bracket)
    {
        let docRef = db.collection("Brackets").document(bracket.id).collection("Teams").document(team.id)
        
        docRef.setData(team.toDictionaryValues(), merge: true) {
            error in
            if let error = error {
                print("Error in writing document: \(error)")
            } else {
                print("Document \(team.name) sucessfully added to \(bracket.name) to Firestore")
            }
        }
    }
    
    // Do a batch update of all teams in a bracket. This should be called when we reorder the list
    func updateAllTeamsInBracket(bracket: Bracket)
    {
        let docRef = db.collection("Brackets").document(bracket.id).collection("Teams")
        
        // Get new write batch
        let batch = db.batch()
        
        for team in bracket.teams {
            let teamRef = docRef.document(team.id)
            batch.updateData(team.toDictionaryValues(), forDocument: teamRef)
        }

        // Commit the batch
        batch.commit() { err in
            if let err = err {
                print("Error writing batch on all teams\(err)")
            } else {
                print("Batch write succeeded on updating all teams")
            }
        }
    }
    
    
    func updateBracket(bracket: Bracket)
    {
        
        let docRef = db.collection("Brackets").document(bracket.id)
        
        docRef.setData(bracket.toDictionaryValues(), merge: true) {
            error in
            if let error = error {
                print("Error in writing document: \(error)")
            } else {
                print("Document \(bracket.name) sucessfully saved to Firestore")
            }
        }
    }
    
//    func updateBracket(bracket: Bracket)
//    {
//
//        let docRef = db.collection("Brackets").document(bracket.id)
//
//        docRef.setData(bracket.toDictionaryValues(), merge: true) {
//            error in
//            if let error = error {
//                print("Error in updating document: \(error)")
//            } else {
//                print("Document \(bracket.name) sucessfully updated to Firestore")
//            }
//        }
//
//
//    }
    
    func loadBrackets(completion: @escaping ([Bracket]) -> ())
    {
        db.collection("Brackets").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else {
                guard let snapshot = querySnapshot else { return }
                var brackets: [Bracket] = []
                
                for doc in snapshot.documents {
                    let foundBracket = Bracket(snapshot: doc)
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
    
    func loadTeamsInBracket(bracket: Bracket, completion: @escaping ([Team]) -> ())
    {
        db.collection("Brackets").document(bracket.id).collection("Teams").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            else {
                guard let snapshot = snapshot else { return }
                var teams: [Team] = []
                
                for doc in snapshot.documents {
                    let foundTeam = Team(snapshot: doc)
                    teams.append(foundTeam)
                }
                
                teams = teams.sorted {
                    $0.rank < $1.rank
                }
                completion(teams)
            }
        }
    }
}
