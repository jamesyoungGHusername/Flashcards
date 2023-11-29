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
    var showToolbar:Bool = true
    @State var addNew:Bool = false
    

    
    var body: some View {
        if(showToolbar){
            List{
                ForEach(deck.cards){card in
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
                }.onDelete(perform: deleteItems)
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
