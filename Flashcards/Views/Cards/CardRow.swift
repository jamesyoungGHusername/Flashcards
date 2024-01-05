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
            ForEach(Array(randomizeFaces ? card.sortedFaces.shuffled().enumerated() : card.sortedFaces.enumerated()),id:\.offset){index,face in
                if(index == 2){
                    Text(face.text)
                        .lineLimit(3)
                        .frame(maxWidth: .infinity)
                }else if (index<2){
                    Text(face.text)
                        .lineLimit(3)
                        .frame(maxWidth: .infinity)
                    Divider()
                }
            }
        }.padding(.vertical)
    }
}

