//
//  CardListView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @State var deck:Deck
    var showToolbar:Bool = true
    @State var addNew:Bool = false
    
    
    init (for deck:Deck,showToolbar:Bool = true){
        self.deck = deck
        self.showToolbar = showToolbar
    }
    
    var body: some View {
        List{
            ForEach(deck.cards){card in
                VStack{
                    Text(card.sideA.text)
                    Text(card.sideB.text)
                }
                .tag(card)
            }
            if(!showToolbar){
                HStack{
                    Button(action: addCard){
                        Label("Add Card", systemImage: "plus")
                    }
                }
            }
        }.toolbar {
            if(showToolbar){
                ToolbarItem {
                    Button(action: addCard) {
                        Label("New Card", systemImage: "plus")
                    }
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
