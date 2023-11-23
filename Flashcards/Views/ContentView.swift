//
//  ContentView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    @State public var addNew: Bool = false;
    @State private var selectedDeck: Deck? = nil
    @State private var selectedCard: Card? = nil
    @Query private var decks: [Deck]

    var body: some View {
        NavigationSplitView {
            DeckListView(selectedDeck: $selectedDeck)
        } content:{
            if let deck = selectedDeck{
                CardListView(for: deck, selectedCard: $selectedCard)
            }else {
                Text("Placeholder")
            }
        }detail: {
            if let card = selectedCard{
                CardDetailView(for: card)
            }else {
                Text("Placeholder")
            }
        }
    }
    

}

#Preview {
    ContentView()
        .modelContainer(for: Deck.self, inMemory: true)
}
