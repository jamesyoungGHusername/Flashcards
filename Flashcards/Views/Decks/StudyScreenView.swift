//
//  StudyScreenView.swift
//  Flashcards
//
//  Created by James Young on 11/29/23.
//

import SwiftUI

struct StudyScreenView: View {
    @Binding var deck:Deck
    var body: some View {
        GeometryReader{proxy in
            ScrollView{
                VStack{
                    ForEach(deck.cards){card in
                        ZStack{
                            TabView{
                                Text(card.sideA.text)
                                    .lineLimit(nil)
                                    .padding(.horizontal)
                                Text(card.sideB.text)
                                    .lineLimit(nil)
                                    .padding(.horizontal)

                            }.tabViewStyle(PageTabViewStyle())
                            .frame(
                                width: proxy.size.width*0.9,
                                height: proxy.size.height*0.75
                            )
                            .background(.gray)
                        }.frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )

                    }
                }
            }.scrollTargetBehavior(.paging)
        }
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
