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
        if(showToolbar){
            List{
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
        }else{
            List{
                ForEach(deck.cards){card in
                    VStack{
                        Text(card.sideA.text)
                        Text(card.sideB.text)
                    }
                    .tag(card)
                }

                HStack{
                    Button(action: addCard){
                        Label("Add Card", systemImage: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $addNew, content: {
                CreateCardView(isPresented: $addNew,deck:$deck)
            })
            .listStyle(.plain)
        }


    }
   private func addCard() {
       addNew = true;
   }
}
