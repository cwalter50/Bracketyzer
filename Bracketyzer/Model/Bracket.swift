//
//  Bracket.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import Foundation


class Bracket: Identifiable, Codable, ObservableObject
{
    @Published var name: String
    @Published var about: String
    @Published var created: Double // this is the timeStamp it was created

    @Published var teams: [Team]
    
    @Published var id: UUID
    

    
    init(name: String = "", about: String = "", id: UUID = UUID(), teams: [Team] = [])
    {
        self.name = name
        self.about = about
        self.id = id
        self.teams = teams
        self.created = Date().timeIntervalSince1970
        
    }
    
    
    func updateTeamRanks()
    {
        for i in 0..<teams.count
        {
            teams[i].rank = i+1
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case about
        case teams
        case id
        case created
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        about = try values.decode(String.self, forKey: .about)
        teams = try values.decode([Team].self, forKey: .teams)
        id = try values.decode(UUID.self, forKey: .id)
        created = try values.decode(Double.self, forKey: .created)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(about, forKey: .about)
        try container.encode(teams, forKey: .teams)
        try container.encode(id, forKey: .id)
        try container.encode(created, forKey: .created)
    }
}
