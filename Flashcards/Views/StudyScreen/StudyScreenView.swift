//
//  StudyScreenView.swift
//  Flashcards
//
//  Created by James Young on 11/29/23.
//

import SwiftUI

struct StudyScreenView: View {
    @Bindable var deck:Deck
    @State var cards:[WorkingCard]
    @State private var scrollPosition: CGPoint = .zero
    @State private var initialOffset: CGFloat = 0
    @State private var stepSize: CGFloat = 0
    private var diffFromInitial:CGFloat{
        get{
            return (self.scrollPosition.y * -1) - (self.initialOffset * -1)
        }
    }
    init(deck: Deck) {
        self.deck = deck
        _cards = State(initialValue: deck.cards.sorted(by: {$0.order < $1.order}).map({(card)-> WorkingCard in
            return WorkingCard(id:card.id,sideA: WorkingSide(id:card.sideA.id,text: card.sideA.text), sideB: WorkingSide(id:card.sideB.id,text: card.sideB.text))}
        )
        )
        self.scrollPosition = scrollPosition
        self.initialOffset = initialOffset
        self.stepSize = stepSize

    }
    private var cardNumber:Int{
        get{
            if(diffFromInitial == 0){
                return 1
            }else{
                let currentDiffWithOffset = diffFromInitial + (stepSize/2)
                let screensFromStart = Int(currentDiffWithOffset / stepSize) + 1
                if(screensFromStart <= cards.count){
                    return screensFromStart
                }else{
                    return cards.count
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
                        Text("VSTACK")
                        ForEach(Array(cards.enumerated()),id:\.offset){index,card in
                            StudyCardView(deck: $cards, card: card, cardHeight: cardHeight,index:index)
                        }
                    }.background(GeometryReader { vertical in
                        Color.clear
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
                        print(proxy.size.height)
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

struct WorkingCard{
    var id:UUID
    var sideA:WorkingSide
    var sideB:WorkingSide
}
struct WorkingSide{
    var id:UUID
    var text:String
}
