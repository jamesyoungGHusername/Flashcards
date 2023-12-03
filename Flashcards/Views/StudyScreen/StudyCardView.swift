//
//  StudyCardView.swift
//  Flashcards
//
//  Created by James Young on 11/30/23.
//

import SwiftUI

struct StudyCardView: View {
    var deck:Deck
    @State var card:Card
    @State var disableDiscard:Bool = true
    @State private var selectedItem = 1
    let cardHeight:CGFloat
    let index:Int
    var body: some View {
        ZStack{
            TabView(selection: $selectedItem){
                cardBody
                    .tag(1)
                ZStack{
                    Color.red
                    VStack{
                        Text("DISCARD")
                    }
                }.padding()
                .frame(height:cardHeight)
                .tag(2)
            }.tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .background(Color(.systemGroupedBackground))
            .frame(height:cardHeight)
            .onChange(of: selectedItem) { oldValue, newValue in
                if(newValue == 2){
                    print("call discard here.")
                }
            }
            .animation(.easeOut(duration: 0.2), value: selectedItem)
            if(index == deck.cards.count-1){
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image(systemName: "repeat")
                            .foregroundStyle(Color.blue)
                        Spacer()
                        Image(systemName: "shuffle")
                            .foregroundStyle(Color.blue)
                        Spacer()
                    }
                }
                    .safeAreaPadding(.bottom)
                    .padding(.bottom,30)
            }else{
                VStack{
                    Spacer()
                    Image(systemName: "arrow.down")
                        .foregroundStyle(Color.blue)
                }.safeAreaPadding(.bottom)
                    .padding(.bottom,30)

            }
        }.containerRelativeFrame(.vertical)
    }
    
    
    var cardBody: some View{
        TabView{
            VStack(spacing:0){
                Color(red: 250, green: 250, blue: 245)
                    .frame(height: 30)
                    Color.red
                        .frame(height: 2)
                ZStack{
                    Color(red: 250, green: 250, blue: 245)
                    VStack{
                        Spacer()
                        Text(card.sideA.text)
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .foregroundStyle(Color.black)
                        Spacer()
                        HStack{
                            Spacer()
                            Image(systemName: "arrow.turn.down.right")
                                .foregroundStyle(Color.blue)
                        }
                        .padding()
                        .padding(.bottom,35)
                    }
                }
            }.padding(.leading)
                .frame(height:cardHeight)
            VStack(spacing:0){
                Color(red: 250, green: 250, blue: 245)
                    .frame(height: 30)
                    Color.red
                        .frame(height: 2)
                ZStack{
                    Color(red: 250, green: 250, blue: 245)
                    VStack{
                        Spacer()
                        Text(card.sideB.text)
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .foregroundStyle(Color.black)
                        Spacer()
                        HStack{
                            Image(systemName: "arrow.turn.down.left")
                                .foregroundStyle(Color.blue)
                            Spacer()
                            Button(action: {selectedItem = 2}){
                                Label("Discard",systemImage: "delete.right")
                                    .foregroundStyle(Color.blue)
                            }

                        }
                        .padding()
                        .padding(.bottom,35)
                    }
                }
            }.padding(.trailing)
                .frame(height:cardHeight)

        }.tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height:cardHeight)
    }
}

