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
    var sideA:Face
    var sideB:Face
    var creationDate:Date

    
    init(sideA:Face,sideB:Face){
        self.sideA = sideA
        self.sideB = sideB
        self.id = Foundation.UUID()

        self.creationDate = Date.now

    }
    static func example() -> Card{
        return Card(sideA: Face(text:"side a"), sideB:Face(text: "side b"))
    }
}

@Model
final class Face:ObservableObject{
    @Attribute(.unique) var id: UUID
    var text:String
    
    init(text:String){
        self.text = text
        self.id = Foundation.UUID()
    }
}

