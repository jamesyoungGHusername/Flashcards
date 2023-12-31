//
//  CardListView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @Environment(\.editMode) private var editMode
    @State var deck:Deck
    var cards:[Card]
    var showToolbar:Bool = true
    @State var addNew:Bool = false
    var randomizeCards = false
    var randomizeFaces = false
    init(deck: Deck, cards: [Card], showToolbar: Bool = true, addNew: Bool = false, randomizeCards: Bool = false, randomizeFaces: Bool = false) {
        _deck = State(initialValue: deck)
        self.cards = randomizeCards ? cards.shuffled() : cards
        self.showToolbar = showToolbar
        self.addNew = addNew
        self.randomizeCards = randomizeCards
        self.randomizeFaces = randomizeFaces
    }
    
    var body: some View {
        if(showToolbar){
            List{
                ForEach(deck.sortedCards){card in
                    VStack{
                        Text(card.sortedFaces[0].text)
                    }
                    .tag(card)
                }.onDelete(perform: deleteItems)
            }.toolbar {
                ToolbarItem {
                    Button(action: addCard) {
                        Label("New Card", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: addCard) {
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $addNew, content: {
                CreateCardView(deck:$deck,isPresented: $addNew)
            })
            .navigationTitle(deck.title)
            .navigationBarTitleDisplayMode(.inline)
        }else{
            ZStack{
                List{
                    ForEach(cards){card in
                        VStack{
                            NavigationLink(destination: CardDetailView(deck: $deck, card: card)){
                                CardRow(card: card,randomizeFaces:randomizeFaces)
                            }
                            
                        }
                    }.onDelete(perform: deleteItems)
                    HStack{
                        Button(action: addCard){
                            Label("Add Card", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $addNew, content: {
                    CreateCardView(deck:$deck,isPresented: $addNew)
                })
                .listStyle(.plain)
            }.navigationBarTitleDisplayMode(.inline)

        }


    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let sorted = deck.cards.sorted(by: {$0.order < $1.order})
                let trueIndex = deck.cards.firstIndex(of:sorted[index])
                if(trueIndex != nil){
                    deck.cards.remove(at: trueIndex!)
                }
                
            }
        }
    }
    private func addCard() {
       addNew = true;
    }
}
