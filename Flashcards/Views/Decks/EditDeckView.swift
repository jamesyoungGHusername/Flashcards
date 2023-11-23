//
//  EditDeckView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct EditDeckView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var deck:Deck;
    
    var body: some View {
        VStack{
            Text("Edit Deck")
            Text(deck.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
        }
    }
    

}

