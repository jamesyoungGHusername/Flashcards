//
//  DeckDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/24/23.
//

import SwiftUI
import SwiftData

struct DeckDetailView: View {
    @Bindable var deck:Deck
    @State private var action: Int? = 0
    @Environment(\.editMode) private var editMode
    


    var body: some View {
        ZStack{
            NavigationLink(destination: StudyScreenView(deck:deck), tag: 1, selection: $action) {
                EmptyView()
            }
            VStack{
                HStack{                
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Untitled",text:$deck.title)
                            .font(.title)
                    }else{
                        if(deck.title != ""){
                            Text(deck.title)
                                .font(.title)
                        }else{
                            Text("Untitled").foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                }
                Button(action: {action = 1}, label: {
                    Text("Study")
                }).frame(maxWidth: .infinity)
                    .padding()
                    .buttonStyle(.borderedProminent)
                CardListView(deck:deck,cards:deck.cards,showToolbar: false)
            }
        }.toolbar {
            EditButton()
        }

    }
}

