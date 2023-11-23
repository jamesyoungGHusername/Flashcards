//
//  CardDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CardDetailView: View {
    @Binding var card:Card
    
    init (for card: Binding<Card>){
        self._card = card
    }
    var body: some View {
        Text(card.sideA.text)
    }
}

