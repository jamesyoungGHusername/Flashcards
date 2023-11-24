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
    @State var csv:CSV<Named>?
    @Binding var isPresented:Bool
    
    init(fileUrl: URL, isPresented: Binding<Bool>) {
        self._fileUrl = State(initialValue:fileUrl)
        self._isPresented = isPresented
        do{
            print("parsing csv")
            let gotAccess = fileUrl.startAccessingSecurityScopedResource()
            if !gotAccess { return }
            let csv = try CSV<Named>(url: fileUrl)
            self._csv = State(initialValue: csv)
            print("csv parsed")
            print(csv.header)
            
            //fileUrl.stopAccessingSecurityScopedResource()
        } catch {
            print("Unexpected error: \(error).")
            // Catch errors from trying to load files
        }
    }
    
    var body: some View {
        if(fileUrl.pathExtension == ".csv"){
            Text("CSV file")
        }else if(fileUrl.pathExtension == ".xlsx"){
            Text("xlsx file")
        }else{
            Text(fileUrl.absoluteString)
        }
    }
}

