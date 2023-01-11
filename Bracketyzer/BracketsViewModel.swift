//
//  BracketsViewModel.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/11/23.
//

import Foundation

class BracketsViewModel: ObservableObject {
    
    @Published var brackets: [Bracket] = []
    
    let firManager = FirestoreManager()
    
    
    init()
    {
        loadBrackets()
    }
    
    func loadBrackets()
    {
        firManager.loadBrackets { [weak self] theBrackets in
            DispatchQueue.main.async {
                self?.brackets = theBrackets
            }
        }
    }
}
