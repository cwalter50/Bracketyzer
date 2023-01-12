//
//  EditBracketView.swift
//  Bracketyzer
//
//  Created by Christopher Walter on 1/10/23.
//

import SwiftUI

struct EditBracketView: View {
    
//    @ObservedObject var bracket: Bracket
    @State var newName: String = ""
    
    @State private var editMode = EditMode.active
    
    @ObservedObject var vm: BracketViewModel
    
    init()
    {
//        bracket = Bracket()
        vm = BracketViewModel()
    }
    
    init(bracket: Bracket)
    {
//        self.bracket = bracket
        vm = BracketViewModel(b: bracket)
    }
    
    var body: some View {
        VStack {
            TextField("Bracket Name", text: $vm.bracket.name)
                .font(.title)
                .onSubmit(saveBracketToFirebase)
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text("About:")
                    .font(.headline)
                TextEditor(text: $vm.bracket.about)
                    .frame(height: 75)
            }
            Spacer()
            Divider()
            Text("Teams and Rankings")
                .font(.title3)
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
                ForEach(vm.bracket.teams) {
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
                    saveBracketToFirebase()
                } label: {
                    Text("Save")
                }
                .disabled(vm.bracket.name == "")

            }
        }
        .onAppear {
            vm.loadTeams()

        }
        
    }
    
    func move(from: IndexSet, to: Int) {

        print("Moving item at position \(from.count) to position \(to)")
        vm.bracket.teams.move(fromOffsets: from, toOffset: to)
        vm.bracket.updateTeamRanks()
        
    }
    
    func addTeam()
    {
        let newTeam = Team(name: newName, rank: vm.bracket.teams.count + 1)
        
        vm.bracket.teams.append(newTeam)
        newName = ""
        
        vm.addTeamToBracket(team: newTeam)
        
    }
    
    func saveBracketToFirebase() {
        vm.saveBracket()
    }
    
}

struct EditBracketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditBracketView()
        }
       
    }
}
