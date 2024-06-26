//
//  MyFieldListItemView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 30.03.2024.
//

import Foundation
import SwiftUI


struct MyFieldListItemViewModel: Codable, Identifiable, Equatable, Hashable {
    let title: String
    let place: String
    let id: Int
}

struct MyFieldListItemView: View {
    
    var model: MyFieldListItemViewModel
    
    var body: some View{
        VStack {
            Text(model.place)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 163/255, green: 172/255, blue: 182/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.leading, 16)

            Text(model.title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 33/255, green: 33/255, blue: 33/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }
}
