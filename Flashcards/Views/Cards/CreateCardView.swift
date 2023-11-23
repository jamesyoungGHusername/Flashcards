//
//  CreateCardView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CreateCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented:Bool
    @Binding var deck:Deck
    var body: some View {
        Button(action: {addItem()}, label: {
            Text("Dismiss create card view")
        })
    }
    
    func addItem(){
        let newItem = Card.example()
        deck.cards.append(newItem)
        isPresented = false;
    }
}

