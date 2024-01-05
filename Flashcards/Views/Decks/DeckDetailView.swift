//
//  DeckDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/24/23.
//

import SwiftUI
import SwiftData

struct DeckDetailView: View {
    @Bindable var deck:Deck
    @State private var action: Int? = 0
    @State private var randomizeCards: Bool = false
    @State private var randomizeFaces: Bool = false
    @Environment(\.editMode) private var editMode
    


    var body: some View {
        ZStack{
            NavigationLink(destination: StudyScreenView(deck:deck,randomizeCards:randomizeCards,randomizeFaces:randomizeFaces), tag: 1, selection: $action) {
                EmptyView()
            }
            VStack{
                HStack{                
                    if editMode?.wrappedValue.isEditing == true {
                        TextField("Untitled",text:$deck.title)
                            .font(.title)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.secondary, lineWidth: 4)
                            )
                            .padding()
                    }else{
                        if(deck.title != ""){
                            Text(deck.title)
                                .font(.title)
                                .padding(.horizontal)
                        }else{
                            Text("Untitled").foregroundStyle(.secondary)
                                .font(.title)
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
                Toggle("Randomize Cards",isOn: $randomizeCards)
                Toggle("Randomize Faces",isOn: $randomizeFaces)

                CardListView(deck:deck,cards:deck.sortedCards,showToolbar: false,randomizeCards: randomizeCards,randomizeFaces: randomizeFaces)
                if editMode?.wrappedValue.isEditing != true {
                    Button(action: {action = 1}, label: {
                        Text("Study")
                    }).frame(maxWidth: .infinity)
                        .padding()
                        .buttonStyle(.borderedProminent)
                }
            }
        }.toolbar {
            EditButton()
        }

    }
}

