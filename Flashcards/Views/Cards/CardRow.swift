//
//  CardRow.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CardRow: View {
    var card:Card
    var body: some View {
        HStack{
            Text(card.sideA.text)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
            Divider()
            Text(card.sideB.text)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
        }.padding(.vertical)
    }
}

