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
    
    var body: some View {
        if(showToolbar){
            List{
                ForEach(cards){card in
                    VStack{
                        Text(card.sideA.text)
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
                    ForEach(Array(cards.enumerated()),id:\.offset){index,card in
                        VStack{
                            NavigationLink(destination: CardDetailView(deck: $deck, card: card,index: index)){
                                CardRow(card: card)
                            }
                            
                        }
                        .tag(card)
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
                deck.cards.remove(at: index)
            }
        }
    }
    private func addCard() {
       addNew = true;
    }
}
