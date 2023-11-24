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
       @Binding var selectedDeck: Deck?
    
    var body: some View {

            List{
                ForEach(decks) { deck in
                    NavigationLink(destination: CardListView(for: deck)){
                        if(deck.title != ""){
                            Text(deck.title)
                        }else{
                            HStack{
                                Text("Untitled Deck").foregroundStyle(.secondary)
                                Text(deck.timestamp,style:.date)
                            }
                            
                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: CreateDeckView(), label: {Label("New Deck", systemImage: "plus")})
                }
            }
            .navigationTitle("Flashcard Decks")
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(decks[index])
            }
        }
    }
}

