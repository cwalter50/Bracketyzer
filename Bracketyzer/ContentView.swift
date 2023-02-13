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
    
    @EnvironmentObject var vm: BracketsViewModel
    
    var body: some View {
        List {
            ForEach(vm.brackets) { bracket in
                NavigationLink {
                    EditBracketView(bracket: bracket)
                } label: {
                    Text("\(bracket.name)")
                }

//                Text(bracket.name)
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
            }
        }
        .onAppear {
            vm.loadBrackets()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environmentObject(BracketsViewModel())
        
        
    }
}

// testing github
