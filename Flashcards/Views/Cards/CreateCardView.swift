//
//  CreateCardView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CreateCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var deck:Deck

    @State var sideA:String
    @State var sideB:String
    @FocusState var sideAFocued:Bool
    @FocusState var sideBFocued:Bool
    @State var fullScreenHeight = 1.0
    @State var hasResized = false
    @Binding var isPresented:Bool
    
    init(deck: Binding<Deck>,isPresented:Binding<Bool>) {
        _deck = deck
        _sideA = State(initialValue: "")
        _sideB = State(initialValue: "")
        _isPresented = isPresented
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
                            }
                        }
                    

                }.frame(height: fullScreenHeight)
            }
            .onChange(of: proxy.size.height){oldValue,newValue in
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
                if(!(sideA == "" && sideB == "")){
                    deck.cards.append(Card(faces:[Face(text: sideA), Face(text: sideB)]))
                }
                
            }
    }
}

