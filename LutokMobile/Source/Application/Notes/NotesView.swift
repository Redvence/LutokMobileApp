//
//  NotesView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation
import SwiftUI

struct NotesView: View {
    
    @ObservedObject
    var viewModel: NotesViewModel
    
    @State
    var newFiledIsPresented: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.items) { item in
                        NoteListItemView(model: item)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .background(Color.clear)
                            .frame(width: 344, height: 100)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 251/255, blue: 255/255))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                }   .listStyle(.plain)
                    .background(Color.white)
            }
            VStack {
                Spacer()
                Button {
                    newFiledIsPresented = true
                } label: {
                    Image(systemName: "plus")
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.white)
                }
                .frame(width: 74, height: 74)
                    .background(Color(red: 255/255, green: 151/255, blue: 245/255))
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
        }.onAppear {
            viewModel.onAppear()
        }.sheet(isPresented: $newFiledIsPresented) {
            let id = viewModel.id
            NewNoteView(viewModel: NewNoteViewModel(id: id, service: NotesService(), onDismiss: {
                newFiledIsPresented = false
                viewModel.onAppear()
            }))
        }
    }
}

struct PreviewProvider_Previews: PreviewProvider {
    
    @Binding var isPresented: Bool
    
    static var viewModel = NotesViewModel(id: -1)
    
    static var previews: some View {
        NotesView(viewModel: viewModel, newFiledIsPresented: false)
    }
}
