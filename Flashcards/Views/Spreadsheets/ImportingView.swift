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
                VStack{
                    HStack{
                        Text("Select Loaded Cards")
                        Text("\(selectedCards.count)/\(rows!.count)")
                    }
                    List(rows!,selection: $selectedCards){row in
                        HStack{
                            ForEach(row.cells){cell in
                                Text(cell.text)
                            }
                        }
                    }
                    .environment(\.editMode, $editMode)
                }
                VStack{
                    Spacer()
                    Button("Done", action: {
                        let selected = rows?.filter{row in
                            selectedCards.contains(row.id)
                        }
                        if(!(selected?.isEmpty ?? true)){
                            selected!.forEach{ row in
                                //Use first non empty column for side A
                                let sideA = row.cells.first(where: {$0.text != ""})
                                //Use last non empty column for side B, unless there's only one empty column
                                let sideB = row.cells.last(where: {$0.text != "" && $0.text != sideA?.text ?? ""})
                                parentDeck.cards.append(
                                    Card(sideA: Face(text: sideA?.text ?? ""), sideB: Face(text: sideB?.text ?? ""))
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
