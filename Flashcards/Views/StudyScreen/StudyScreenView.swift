//
//  StudyScreenView.swift
//  Flashcards
//
//  Created by James Young on 11/29/23.
//

import SwiftUI

struct StudyScreenView: View {
    @Binding var deck:Deck
    @State private var scrollPosition: CGPoint = .zero
    @State private var maxScrollPosition: CGFloat = 0
    @State private var initialOffset: CGFloat = 0
    @State private var stepSize: CGFloat = 0
    private var diffFromInitial:CGFloat{
        get{
            return (self.scrollPosition.y * -1) - (self.initialOffset * -1)
        }
    }
    private var cardNumber:Int{
        get{
            if(diffFromInitial == 0){
                return 1
            }else{
                let currentDiffWithOffset = diffFromInitial + (stepSize/2)
                let screensFromStart = Int(currentDiffWithOffset / stepSize) + 1
                if(screensFromStart <= deck.cards.count){
                    return screensFromStart
                }else{
                    return deck.cards.count
                }
            }
        }
    }

    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                let cardHeight = proxy.size.height*0.6
                ScrollView(showsIndicators: false){
                    VStack(spacing: 0){
                        ForEach(Array(deck.cards.enumerated()),id:\.offset){index,card in
                            StudyCardView(deck: $deck, card: card, cardHeight: cardHeight,index:index)
                        }
                    }.background(GeometryReader { vertical in
                        Color.clear
                            .onAppear(){
                                self.maxScrollPosition = vertical.size.height
                            }
                            .preference(key: ScrollOffsetPreferenceKey.self, value: vertical.frame(in: .named("scroll")).origin)
                            .onChange(of: scrollPosition) {oldValue, newValue in
                                if(initialOffset == 0 && newValue.y != 0){
                                    initialOffset = newValue.y
                                }
                            }
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        self.scrollPosition = value
                    }
                }.scrollTargetBehavior(.paging)
                    .ignoresSafeArea()
                    .coordinateSpace(name:"scroll")
                    .onAppear(){
                        self.stepSize = proxy.size.height
                    }
            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle(deck.title)
            .toolbar{
                ToolbarItem{
                    Text("\(cardNumber) / \(deck.cards.count)")
                }
            }
    }
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
