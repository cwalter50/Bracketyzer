//
//  BracketViewModel.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/11/23.
//

import Foundation

class BracketViewModel: ObservableObject {
    
    @Published var bracket: Bracket // this is used to see the current bracket in EditBracketView or BracketView
    
    let firManager = FirestoreManager()
    
    init()
    {
        bracket = Bracket()
//        loadTeams()
    }
    
    init(b: Bracket)
    {
        bracket = b
        loadTeams()
    }
    
    
    func loadTeams()
    {
        firManager.loadTeamsInBracket(bracket: bracket) { [weak self] theTeams in
            DispatchQueue.main.async {
                self?.bracket.teams = theTeams
//                print("Found \(theTeams.count) Teams for \(self?.bracket.name ?? "")")
            }
        }
    }
    
    func saveBracketToFirestore()
    {
        firManager.updateBracket(bracket: self.bracket)
    }
    
    func addTeamToBracketInFirestore(team: Team)
    {
        firManager.addTeamToBracket(team: team, bracket: self.bracket)
    }
    
    // this will do a batch update of all teams
    func updateAllTeamsInBracketInFirestore()
    {
        firManager.updateAllTeamsInBracket(bracket: self.bracket)
    }
}
