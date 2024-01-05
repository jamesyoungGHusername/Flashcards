//
//  Deck.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import Foundation
import SwiftData

@Model
final class Deck {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var title: String
    @Relationship(deleteRule:.cascade) var cards:[Card]
    var sortedCards:[Card]{
        return cards.sorted(by: {$0.order < $1.order})
    }
    
    init(timestamp: Date,title:String,cards:[Card]=[]) {
        self.timestamp = timestamp
        self.title = title
        self.cards = cards
        self.id = Foundation.UUID()
    }
    
    static func example() -> Deck{
        let newDeck = Deck(timestamp:Date.now,title:"Example Deck")
        newDeck.cards = [Card.example()]
        return newDeck
    }
}

@Model
final class Card{
    @Attribute(.unique) var id: UUID
    var faces:[Face]
    var order:Int
    var creationDate:Date
    var sortedFaces:[Face]{
        return faces.sorted(by: {$0.order < $1.order})
    }

    
    init(faces:[Face],order:Int = 0){
        self.faces = faces
        self.id = Foundation.UUID()
        self.order = order
        self.creationDate = Date.now

    }
    static func example() -> Card{
        return Card(faces: [Face(text:"side a"),Face(text: "side b")])
    }
}

@Model
final class Face:ObservableObject{
    @Attribute(.unique) var id: UUID
    var text:String
    var order:Int
    
    init(text:String,order:Int = 0){
        self.text = text
        self.id = Foundation.UUID()
        self.order = order
    }
}

