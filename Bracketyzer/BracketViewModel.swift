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
    
    func saveBracket()
    {
        firManager.updateBracket(bracket: self.bracket)
    }
    
    func addTeamToBracket(team: Team)
    {
        firManager.addTeamToBracket(team: team, bracket: self.bracket)
    }
}
