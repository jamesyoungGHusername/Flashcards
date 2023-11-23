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
        if(!addNew){
            List{
                ForEach(decks) { deck in
                    NavigationLink(destination: CardListView(for: deck)){
                        Text(deck.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: CreateDeckView(isPresented: $addNew), label: {Label("New Deck", systemImage: "plus")})

                }
            }
            .navigationTitle("Flashcard Decks")
        }else{
            
        }
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

