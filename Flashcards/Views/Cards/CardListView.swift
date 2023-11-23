//
//  CardListView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @Binding var selectedCard:Card?
    @State var addNew:Bool = false
    @State var deck:Deck
    
    init (for deck: Deck, selectedCard:Binding<Card?>){
        self.deck = deck
        self._selectedCard = selectedCard
    }
    
    var body: some View {
        List(selection:$selectedCard){
            ForEach(deck.cards){card in
                VStack{
                    Text(card.sideA.text)
                    Text(card.sideB.text)
                }
                .tag(card)
            }
        }.toolbar {
            ToolbarItem {
                Button(action: addCard) {
                    Label("New Card", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $addNew, content: {
            CreateCardView(isPresented: $addNew,deck:$deck)
        })
        .navigationTitle(deck.title)
        .navigationBarTitleDisplayMode(.inline)
    }
   private func addCard() {
       addNew = true;
   }
}
