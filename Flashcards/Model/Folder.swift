//
//  Folder.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import Foundation
import SwiftData

@Model
final class Folder {
    var uuid:UUID
    var creationDate:Date
    var name:String
    var color_:String?
    var decks: [Deck]
    
    init(name: String = "",decks: [Deck] = []) {
           self.creationDate = Date()
           self.uuid = UUID()
           self.name = name
           self.decks = decks
       }
    
    static func delete(_ folder: Folder) {
        if let context = folder.modelContext {
            context.delete(folder)
        }
    }
}

