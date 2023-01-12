//
//  Team.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import Foundation
import Firebase


class Team: Codable, Identifiable
{
    var name: String
    var rank: Int
    var id: String
    var created: Double = Date().timeIntervalSince1970
    
    init()
    {
        name = "unknown"
        rank = 1
        id = UUID().uuidString
        
    }
    
    init(name: String = "", rank: Int = 1)
    {
        self.name = name
        self.rank = rank
        self.id = UUID().uuidString
    }
    
    // data from Firestore
    init(snapshot: QueryDocumentSnapshot)
    {
        let data = snapshot.data()
        self.name = data["name"] as? String ?? ""
        self.rank = data["rank"] as? Int ?? 1
        self.id = data["id"] as? String ?? UUID().uuidString
        self.created = data["created"] as? Double ?? Date().timeIntervalSince1970
    }
    
    func toDictionaryValues() -> [String: Any]
    {
        let dictionary: [String: Any] = [
            "name": self.name,
            "rank": self.rank,
            "id": self.id,
            "created": self.created

        ]
        
        return dictionary
    }
}
