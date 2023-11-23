//
//  DeckListView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct DeckListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Deck.timestamp, order: .forward)
       var  decks: [Deck]
    @State var addNew:Bool = false
       @Binding var selectedDeck: Deck?
    
    var body: some View {
        List(selection: $selectedDeck) {
            ForEach(decks) { deck in
                NavigationLink(value:deck){
                    Text(deck.title)
                }
            }
            .onDelete(perform: deleteItems)
        }.toolbar {
            ToolbarItem {
                Button(action: addItem) {
                    Label("New Deck", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Flashcard Decks")
        .sheet(isPresented: $addNew, content: {
            CreateDeckView(isPresented: $addNew)
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(decks[index])
            }
        }
    }
    private func addItem() {
        addNew = true;
    }
}

