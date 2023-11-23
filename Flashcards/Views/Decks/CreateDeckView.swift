//
//  CreateDeckView.swift
//  Flashcards
//
//  Created by James Young on 11/23/23.
//

import SwiftUI

struct CreateDeckView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented:Bool;
    @State var deck:Deck = Deck(timestamp: Date(),title:"");
    @State var showImporter:Bool = false;
    @State var fileName = "no file chosen"
    @State var openFile = false
    
    var body: some View {
        VStack{
            HStack{
                Text("New Deck")
                    .bold()
                Spacer()
                Button(action: {openFile = true}) {
                    Label("Import",systemImage: "square.and.arrow.down")
                }
            }
            TextField("Title",text: $deck.title)
            
            Spacer()
            Button(action: addItem, label: {
                Text("New Deck")
            })
        }.padding([.all])
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
    }
    

    func addItem(){
        print(deck.title)
        //modelContext.insert(deck)
        //isPresented = false;
    }
}

import UniformTypeIdentifiers

extension UTType {

    static let xls: Self = .init(filenameExtension: "xls")!
    static let xlsx: Self = .init(filenameExtension: "xlsx")!
    static let csv: Self = .init(filenameExtension: "csv")!

}
