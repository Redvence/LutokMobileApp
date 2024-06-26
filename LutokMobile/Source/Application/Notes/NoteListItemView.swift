//
//  NoteListItemView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation
import SwiftUI

struct NoteListItemViewModel: Codable, Identifiable, Equatable, Hashable {
    let text: String
    let field_id: Int
    let id: Int
}

struct NoteListItemView: View {
    
    var model: NoteListItemViewModel
    
    var body: some View{
        VStack{
            Text(model.text)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 33/255, green: 33/255, blue: 33/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.leading, 16)
        }
    }
}
