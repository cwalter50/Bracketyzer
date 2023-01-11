//
//  EditBracketView.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import SwiftUI

struct EditBracketView: View {
    
    @ObservedObject var bracket: Bracket
    @State var newName: String = ""
    
    @State private var editMode = EditMode.active
    
    @EnvironmentObject var vm: BracketsViewModel
    
    
    var body: some View {
        VStack {
            TextField("Bracket Name", text: $bracket.name)
                .font(.title)
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text("About:")
                    .font(.headline)
                TextEditor(text: $bracket.about)
                    .frame(height: 75)
            }
            Spacer()
            Divider()
            Text("Teams and Rankings")
                .font(.headline)
            Divider()
            HStack {
                TextField("Enter Team", text: $newName)
                    .onSubmit {
                        if newName != "" {
                            addTeam()
                        }
                    }
                Spacer()
                Button {
                    addTeam()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.accentColor)
                        
                }
                .disabled(newName == "")
            }
            .padding(.horizontal)
            List {
//                ForEach(bracket.teams.sorted {$0.rank < $1.rank}) {
                ForEach(bracket.teams) {
                    team in
                    HStack{
                        Image(systemName: "\(team.rank).circle.fill")
                        Text(team.name)
                    }
                }
                .onMove(perform: move)
                
            }
            .listStyle(.plain)
            .environment(\.editMode, $editMode)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    saveToFirebase()
                } label: {
                    Text("Save")
                }
                .disabled(bracket.name == "")

            }
        }
        
    }
    
    func move(from: IndexSet, to: Int) {

        print("Moving item at position \(from.count) to position \(to)")
        bracket.teams.move(fromOffsets: from, toOffset: to)
        bracket.updateTeamRanks()
        
    }
    
    func addTeam()
    {
        let newTeam = Team(name: newName, rank: bracket.teams.count + 1)
        
        bracket.teams.append(newTeam)
        newName = ""
        
    }
    
    func saveToFirebase() {
        vm.firManager.saveBracket(bracket: self.bracket)
    }
}

struct EditBracketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditBracketView(bracket: Bracket())
        }
        .environmentObject(BracketsViewModel())
       
    }
}
