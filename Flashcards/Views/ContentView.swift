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
        NavigationView {
            DeckListView(selectedDeck: $selectedDeck)
        }
    }
    

}

#Preview {
    ContentView()
        .modelContainer(for: Deck.self, inMemory: true)
}
