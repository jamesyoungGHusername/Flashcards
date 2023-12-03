//
//  CardDetailView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI
import SwiftData

struct CardDetailView: View {
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var modelContext

    @Binding var deck:Deck
    @Bindable var card:Card
    @State var sideA:String
    @State var sideB:String
    @State var newText:String = ""
    @FocusState var sideAFocued:Bool
    @FocusState var sideBFocued:Bool
    var index:Int
    @State var fullScreenHeight = 1.0
    @State var hasResized = false
    
    init(deck: Binding<Deck>, card: Card,index:Int) {
        _deck = deck
        _card = Bindable(card)
        _sideA = State(initialValue: card.sideA.text)
        _sideB = State(initialValue: card.sideB.text)
        self.index = index
    }

    
    var body: some View {
        GeometryReader{proxy in
            ScrollView{
                VStack (spacing:20){
                        Text("Side A")
                            .font(.subheadline)
                            .onTapGesture(perform: {
                                sideAFocued = false
                            })
                        VStack(spacing:0){
                            Color(red: 250, green: 250, blue: 245)
                                .frame(height: 30)
                                Color.red
                                    .frame(height: 2)
                            ZStack{
                                Color(red: 250, green: 250, blue: 245)
                                    .onTapGesture(perform: {
                                        sideAFocued = false
                                    })
                                if editMode?.wrappedValue.isEditing == true {
                                    TextField("Side A", text: $sideA, axis: .vertical)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.black)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.secondary, lineWidth: 4)
                                        )
                                        .padding()
                                        .focused($sideAFocued)
                                }else{
                                    Text(sideA)
                                        .lineLimit(nil)
                                        .padding(.horizontal)
                                        .foregroundStyle(Color.black)
                                }
                            }
                        }
                    

                        Text("Side B")
                            .font(.subheadline)
                            .onTapGesture(perform: {
                                sideBFocued = false
                            })
                        VStack(spacing:0){
                            Color(red: 250, green: 250, blue: 245)
                                .frame(height: 30)
                                Color.red
                                    .frame(height: 2)
                            ZStack{
                                Color(red: 250, green: 250, blue: 245)
                                    .onTapGesture(perform: {
                                        sideBFocued = false
                                    })
                                if editMode?.wrappedValue.isEditing == true {
                                    TextField("Side A", text: $sideB, axis: .vertical)
                                        .lineLimit(nil)
                                        .foregroundStyle(Color.black)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.secondary, lineWidth: 4)
                                        )
                                        .padding()
                                        .focused($sideBFocued)
                                }else{
                                    Text(sideB)
                                        .lineLimit(nil)
                                        .padding(.horizontal)
                                        .foregroundStyle(Color.black)
                                }
                            
                            }
                        }
                    

                }.frame(height: fullScreenHeight)
            }
            .onChange(of: proxy.size.height){oldValue,newValue in
                print(oldValue)
                print(newValue)
                if(!hasResized){
                    hasResized = true
                    fullScreenHeight = newValue
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
            .padding(.bottom)
            .toolbar {
                EditButton()
            }
            .onDisappear(){
                deck.cards[index] = Card(sideA: Face(text: sideA), sideB: Face(text: sideB))
            }

       
           
    }
}

