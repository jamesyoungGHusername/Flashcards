//
//  DeckDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/24/23.
//

import SwiftUI
import SwiftData

struct DeckDetailView: View {
    @State var deck:Deck
    @State private var action: Int? = 0
    @Environment(\.editMode) private var editMode
    

    var body: some View {
        VStack{
            NavigationLink(destination: Text("Study Screen"), tag: 1, selection: $action) {
                EmptyView()
            }
            if editMode?.wrappedValue.isEditing == true {
                TextField("Untitled",text:$deck.title)
            }else{
                if(deck.title != ""){
                    Text(deck.title)
                }else{
                    Text("Untitled").foregroundStyle(.secondary)
                }
            }
            CardListView(deck:deck,showToolbar: false)
            Spacer()
            Button(action: {action = 1}, label: {
                Text("Study")
            })
        }.toolbar {
            EditButton()
        }

    }
}

