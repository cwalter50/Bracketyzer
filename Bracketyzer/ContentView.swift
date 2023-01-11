//
//  ContentView.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var brackets: [Bracket] = []
    
    @State var showEditBracketView = false
    
    
    var body: some View {
        List {
            ForEach(brackets) { bracket in
                Text(bracket.name)
            }
        }
        .navigationTitle("Bracketyzer")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditBracketView(bracket: Bracket())
                } label: {
                    Image(systemName: "plus")
                }

//                Button {
//                    addName()
//                } label: {
//                    Image(systemName: "plus")
//                }

            }
        }
        
    }
    
    func addName()
    {
        let bracket = Bracket(name: "hello", about: "sample paragraph")
        brackets.append(bracket)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        
    }
}
