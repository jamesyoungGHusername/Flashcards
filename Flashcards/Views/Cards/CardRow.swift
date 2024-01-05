//
//  CardRow.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CardRow: View {
    var card:Card
    var randomizeFaces:Bool = false
    var body: some View {
        HStack{
            Text(card.sortedFaces[0].text)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
            Divider()
            Text(card.sortedFaces[1].text)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
            Divider()
            Text(card.sortedFaces[2].text)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
        }.padding(.vertical)
    }
}

