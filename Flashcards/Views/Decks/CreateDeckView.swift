//
//  CreateDeckView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CreateDeckView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var decks:[Deck]
    @State var deck:Deck = Deck(timestamp: Date(),title:"");
    @State var selectedCard:Card? = nil
    @State var showImporter:Bool = false
    @State var fileName:URL? = nil
    @State var fileSelected = false
    @State var openFile = false
    @State var showConfirmation = false
    
    var body: some View {

        VStack{
            HStack{
                TextField("Title",text: $deck.title)
                    .bold()
                Spacer()
                Button(action: {openFile = true}) {
                    Label("Import",systemImage: "square.and.arrow.down")
                }
            }
            HStack{
                Text("Cards")
                Spacer()
            }
            CardListView(deck: deck, cards:deck.cards,showToolbar:false)
            Spacer()
            Button(action: addItem, label: {
                Text("Save Deck")
            }).buttonStyle(.borderedProminent)
        }
        .padding([.all])
        .fileImporter( isPresented: $openFile, allowedContentTypes: [.xlsx,.csv], allowsMultipleSelection: false, onCompletion: {
            (Result) in
            do{
                let fileURL = try Result.get()
                print(fileURL)
                self.fileName = fileURL[0]
                fileSelected = true
            }
            catch{
                print("error reading file \(error.localizedDescription)")
            }
        })
        .onAppear(perform: {
            modelContext.insert(deck)
        })
        .navigationBarTitle("Create Deck")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            addItem()
        }){
            Image(systemName: "chevron.backward")
        })
        .sheet(isPresented: $fileSelected, content: {
            if(fileName != nil){
                ImportingView(fileUrl: fileName!,isPresented:$fileSelected,parentDeck: $deck)
            }else{
                EmptyView()
            }
        })
        
    }
    func addItem(){
        self.mode.wrappedValue.dismiss()
    }
    func addCard(){
        print("Adding card")
    }
}

import UniformTypeIdentifiers

extension UTType {

    static let xlsx: Self = .init(filenameExtension: "xlsx")!
    static let csv: Self = .init(filenameExtension: "csv")!

}
