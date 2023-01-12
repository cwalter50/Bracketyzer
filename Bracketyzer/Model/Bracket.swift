//
//  Bracket.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import Foundation
import Firebase


class Bracket: Identifiable, Codable, ObservableObject
{
    @Published var name: String
    @Published var about: String
    @Published var created: Double // this is the timeStamp it was created

    @Published var teams: [Team]
    
    @Published var id: String
    

    
    init(name: String = "", about: String = "", id: String = UUID().uuidString, teams: [Team] = [])
    {
        self.name = name
        self.about = about
        self.id = id
        self.teams = teams
        self.created = Date().timeIntervalSince1970
        
    }
    
    // data from Firestore
    init(snapshot: QueryDocumentSnapshot)
    {
        let data = snapshot.data()
        self.name = data["name"] as? String ?? ""
        self.about = data["about"] as? String ?? ""
        self.id = data["id"] as? String ?? UUID().uuidString
        self.created = data["created"] as? Double ?? Date().timeIntervalSince1970
        self.teams = []
        
        
//        print(data)
    }
    
    
    func updateTeamRanks()
    {
        for i in 0..<teams.count
        {
            teams[i].rank = i+1
        }
    }
    
    func toDictionaryValues() -> [String: Any]
    {
        let dictionary: [String: Any] = [
            "name": self.name,
            "about": self.about,
            "created": self.created,
            "id": self.id,
//            "teams": self.teams
        ]
        
        return dictionary
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
        id = try values.decode(String.self, forKey: .id)
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
