//
//  ContentView.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        List {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
