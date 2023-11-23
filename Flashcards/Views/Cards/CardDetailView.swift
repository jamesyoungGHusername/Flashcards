//
//  CardDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CardDetailView: View {
    @State var card:Card
    
    init (for card: Card){
        self.card = card
    }
    var body: some View {
        Text(card.sideA.text)
    }
}

