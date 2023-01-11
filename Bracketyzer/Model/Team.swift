//
//  Team.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import Foundation


class Team: Codable, Identifiable
{
    var name: String
    var rank: Int
    
    init()
    {
        name = "unknown"
        rank = 1
    }
    
    init(name: String = "unknown", rank: Int = 1)
    {
        self.name = name
        self.rank = rank
    }
}
