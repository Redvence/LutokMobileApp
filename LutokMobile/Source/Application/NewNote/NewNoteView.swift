//
//  NewNoteView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 26.06.2024.
//

import Foundation
import SwiftUI

struct NewNoteView: View {
    @ObservedObject
    var viewModel: NewNoteViewModel
    
    var body: some View {
        let enteredText = Binding<String>(
            get: { self.viewModel.enteredText },
            set: { self.viewModel.enteredText = $0 }
        )
        
        VStack{
            TextField("заметка", text: enteredText)
                .frame(width: 338, height: 35)
                .padding(.horizontal)
                .background(Color.white)
//                .cornerRadius(8)
//                .padding()
            
            Button {
                viewModel.didTapCreateNote()
            } label: {
                Text("Создать")
                    .frame(width: 338, height: 44)
                    .background(Color(red: 23/255, green: 193/255, blue: 251/255))
                    .foregroundColor(.white)
                    .cornerRadius(44)
                    .padding(.vertical, 32)
            }
        }
    }
}
