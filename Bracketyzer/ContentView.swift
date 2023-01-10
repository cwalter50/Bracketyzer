//
//  ContentView.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var brackets: [String] = ["Test", "MarchMadness 2023", "MarchMadness 2022"]
    
    
    var body: some View {
        List {
            ForEach(brackets, id: \.self) { bracket in
                Text(bracket)
            }
        }
        .navigationTitle("Bracketyzer")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addName()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        
        
        
    }
    
    func addName()
    {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        
    }
}
