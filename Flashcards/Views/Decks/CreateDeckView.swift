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
    @State var deck:Deck = Deck(timestamp: Date(),title:"");
    @State var selectedCard:Card? = nil;
    @State var showImporter:Bool = false;
    @State var fileName = "no file chosen"
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
            CardListView(for: deck, showToolbar:false)
            Spacer()
            Button(action: addItem, label: {
                Text("New Deck")
            })
        }
        .padding([.all])
        .fileImporter( isPresented: $openFile, allowedContentTypes: [.xlsx,.xls,.csv], allowsMultipleSelection: false, onCompletion: {
            (Result) in
            do{
                let fileURL = try Result.get()
                print(fileURL)
                self.fileName = fileURL.first?.lastPathComponent ?? "file not available"
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
            if(deck.title != "" && deck.cards.count != 0){
                self.mode.wrappedValue.dismiss()
            }else if(deck.title == "" && deck.cards.count != 0){
                print("no title found")
                showConfirmation = true
            }else{
                modelContext.delete(deck)
                self.mode.wrappedValue.dismiss()
            }
        }){
            Image(systemName: "chevron.backward")
        })
        .alert("Enter a title to save",isPresented: $showConfirmation){
            TextField("Title", text: $deck.title)
            Button("Save", action: submitTitle)
            Button("Discard",role: .destructive,action: discard)
        }
    }
    func submitTitle(){
        if(deck.title != ""){
            showConfirmation=false
            self.mode.wrappedValue.dismiss()
        }
    }
    func discard(){
        modelContext.delete(deck)
        self.mode.wrappedValue.dismiss()
    }
    
    func addItem(){
        print("Adding deck titled \(deck.title)")
        self.mode.wrappedValue.dismiss()
    }
    func addCard(){
        print("Adding card")
    }
}

import UniformTypeIdentifiers

extension UTType {

    static let xls: Self = .init(filenameExtension: "xls")!
    static let xlsx: Self = .init(filenameExtension: "xlsx")!
    static let csv: Self = .init(filenameExtension: "csv")!

}
