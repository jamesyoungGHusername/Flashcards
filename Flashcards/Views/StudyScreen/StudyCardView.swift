//
//  StudyCardView.swift
//  Flashcards
//
//  Created by James Young on 11/30/23.
//

import SwiftUI

struct StudyCardView: View {
    @Binding var deck:Deck
    @State var card:Card
    let cardHeight:CGFloat
    let index:Int
    var body: some View {
        ZStack{
            TabView{
                ZStack{
                    Color.white
                    VStack{
                        Color.red
                            .frame(height: 2)
                            .padding(.top,30)
                        Spacer()
                    }
                    Text(card.sideA.text)
                        .lineLimit(nil)
                        .padding(.horizontal)
                        .foregroundStyle(Color.black)
                }.padding(.leading)
                .frame(height:cardHeight)
                ZStack{
                    Color.white
                    VStack{
                        Color.red
                            .frame(height: 2)
                            .padding(.top,30)
                        Spacer()
                    }
                    Text(card.sideB.text)
                        .lineLimit(nil)
                        .padding(.horizontal)
                        .foregroundStyle(Color.black)
                }.padding(.trailing)
                .frame(height:cardHeight)
            }.tabViewStyle(PageTabViewStyle())
            .containerRelativeFrame(.vertical)
            if(index == deck.cards.count-1){
                VStack{
                    Spacer()
                    Text("SHUFFLE AND REPEAT OPTIONS HERE")
                }
                    .safeAreaPadding(.bottom)
                    .padding(.bottom,30)
            }
        }
    }
}

