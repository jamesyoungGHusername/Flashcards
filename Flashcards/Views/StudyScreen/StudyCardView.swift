//
//  StudyCardView.swift
//  Flashcards
//
//  Created by James Young on 11/30/23.
//

import SwiftUI

struct StudyCardView: View {
    @Binding var deck:[WorkingCard]
    @State var card:WorkingCard
    @State var disableDiscard:Bool = true
    @State private var selectedItem = 1
    let cardHeight:CGFloat
    let index:Int
    var body: some View {
        ZStack{
            Text("card body here")
            cardBody
                .tag(1)
            if(index == deck.count-1){
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Image(systemName: "repeat")
                            .foregroundStyle(Color.blue)
                        Spacer()
                        Image(systemName: "shuffle")
                            .foregroundStyle(Color.blue)
                        Spacer()
                    }
                }
                    .safeAreaPadding(.bottom)
                    .padding(.bottom,30)
            }else{
                VStack{
                    Spacer()
                    Image(systemName: "arrow.down")
                        .foregroundStyle(Color.blue)
                }.safeAreaPadding(.bottom)
                    .padding(.bottom,30)

            }
        }.containerRelativeFrame(.vertical)
    }

    var cardBody: some View{
        TabView{
            ForEach(Array(card.faces.enumerated()),id:\.offset){index,face in
                if(index == 0){
                    leadingFace(face: face)
                }else if(index == card.faces.count-1){
                    trailingFace(face: face)
                }else{
                    middleFace(face: face)
                }
            }

        }.tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height:cardHeight)
    }
    func leadingFace(face:WorkingFace) -> some View{
        VStack(spacing:0){
            Color(red: 250, green: 250, blue: 245)
                .frame(height: 30)
                Color.red
                    .frame(height: 2)
            ZStack{
                Color(red: 250, green: 250, blue: 245)
                VStack{
                    Spacer()
                    Text(face.text)
                        .lineLimit(nil)
                        .padding(.horizontal)
                        .foregroundStyle(Color.black)
                    Spacer()
                    HStack{
                        Spacer()
                        Image(systemName: "arrow.turn.down.right")
                            .foregroundStyle(Color.blue)
                    }
                    .padding()
                    .padding(.bottom,35)
                }
            }
        }.padding(.leading)
        .frame(height:cardHeight)
    }
    
    func trailingFace(face:WorkingFace) -> some View {
        VStack(spacing:0){
            Color(red: 250, green: 250, blue: 245)
                .frame(height: 30)
                Color.red
                    .frame(height: 2)
            ZStack{
                Color(red: 250, green: 250, blue: 245)
                VStack{
                    Spacer()
                    Text(face.text)
                        .lineLimit(nil)
                        .padding(.horizontal)
                        .foregroundStyle(Color.black)
                    Spacer()
                    HStack{
                        Image(systemName: "arrow.turn.down.left")
                            .foregroundStyle(Color.blue)
                        Spacer()
                        Button(action: {
                            print("discard")
                        }){
                            Label("Discard",systemImage: "delete.right")
                                .foregroundStyle(Color.blue)
                        }

                    }
                    .padding()
                    .padding(.bottom,35)
                }
            }
        }.padding(.trailing)
            .frame(height:cardHeight)
    }
    
    func middleFace(face:WorkingFace) -> some View {
        VStack(spacing:0){
            Color(red: 250, green: 250, blue: 245)
                .frame(height: 30)
                Color.red
                    .frame(height: 2)
            ZStack{
                Color(red: 250, green: 250, blue: 245)
                VStack{
                    Spacer()
                    Text(face.text)
                        .lineLimit(nil)
                        .padding(.horizontal)
                        .foregroundStyle(Color.black)
                    Spacer()
                    HStack{
                        Image(systemName: "arrow.turn.down.left")
                            .foregroundStyle(Color.blue)
                        Spacer()
                        Image(systemName: "arrow.turn.down.right")
                            .foregroundStyle(Color.blue)
                    }
                    .padding()
                    .padding(.bottom,35)
                }
            }
        }
        .frame(height:cardHeight)
    }
}

