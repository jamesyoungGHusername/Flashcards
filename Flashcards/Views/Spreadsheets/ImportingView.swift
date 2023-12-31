//
//  ImportingView.swift
//  Flashcards
//
//  Created by James Young on 11/24/23.
//

import SwiftUI
import SwiftCSV

struct ImportingView: View {
    @State var fileUrl:URL
    @State var csv:CSV<Enumerated>?
    @State var rows:[Row]?
    @State var selectedCards = Set<UUID>()
    @State var editMode = EditMode.active
    @Binding var isPresented:Bool
    @Binding var parentDeck:Deck
    @State private var allSelected:Bool = false
    
    init(fileUrl: URL, isPresented: Binding<Bool>,parentDeck:Binding<Deck>) {
        _fileUrl = State(initialValue:fileUrl)
        _isPresented = isPresented
        _parentDeck = parentDeck
        let pathExtension = fileUrl.pathExtension
        if(pathExtension == "csv"){
            do{                let gotAccess = fileUrl.startAccessingSecurityScopedResource()
                if !gotAccess { return }
                let csv = try CSV<Enumerated>(url: fileUrl)
                _csv = State(initialValue: csv)
                _rows = State(initialValue: [
                    Row(cells: csv.header.compactMap{Cell(text: $0)})]+csv.rows.compactMap{ Row(cells: $0.compactMap{Cell(text: $0)}) }
                )
                fileUrl.stopAccessingSecurityScopedResource()
            } catch {
                print("Unexpected error: \(error).")
                // Catch errors from trying to load files
            }
        }
        if(pathExtension == "xlsx"){
            print("excel spreadsheet detected")
        }
    }
    
    var body: some View {
        if(fileUrl.pathExtension == "csv" && csv != nil && rows != nil){
            ZStack{
                VStack(spacing:0){
                    HStack{
                        Text("Select Loaded Cards")
                        Text("\(selectedCards.count)/\(rows!.count)")
                    }
                    Toggle("Select All",isOn: $allSelected)
                    .onChange(of: allSelected){oldValue,newValue in
                        if(newValue == true){
                            selectedCards = []
                            rows?.forEach{row in
                                selectedCards.insert(row.id)
                            }
                        }
                        if(newValue == false && selectedCards.count == rows?.count){
                            selectedCards = []
                        }
                    }.padding(.horizontal)
                    List(rows!,selection: $selectedCards){row in
                        HStack{
                            ForEach(row.cells){cell in
                                Text(cell.text)
                            }
                        }
                    }
                    .environment(\.editMode, $editMode)
                    .onChange(of: selectedCards){oldValue, newValue in
                        if(newValue.count != rows?.count){
                            allSelected = false
                        }
                    }
                    .safeAreaInset(edge: .bottom){
                        Button("Done", action: {
                            let selected = rows?.filter{row in
                                selectedCards.contains(row.id)
                            }
                            if(!(selected?.isEmpty ?? true)){
                                for (index,row) in selected!.enumerated() {
                                    //Use first non empty column for side A
                                    var faces:[String] = []
                                    row.cells.map{
                                        if($0.text != ""){
                                            return faces.append($0.text)
                                        }
                                    }
                                    parentDeck.cards.append(
                                        Card(faces:faces.enumerated().map{ (index, element) in
                                            Face(text: element, order: index)
                                        },order:index)
                                    )
                                }
                                isPresented = false
                            }
                            
                            //parentDeck.cards.append()
                            //isPresented = false
                        })
                          .buttonStyle(.borderedProminent)
                    }
                }

            }
        }else if(fileUrl.pathExtension == "xlsx"){
            Text("xlsx file")
        }else{
            Text(fileUrl.absoluteString)
        }
    }
}

struct Row:Identifiable{
    let id:UUID = UUID()
    let cells:[Cell]
}

struct Cell:Identifiable{
    let id:UUID = UUID()
    let text:String
}
