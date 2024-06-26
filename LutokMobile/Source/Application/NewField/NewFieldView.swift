//
//  NewFieldView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 25.06.2024.
//

import Foundation
import SwiftUI

struct NewFieldView: View {
    
    @ObservedObject
    var viewModel: NewFieldViewModel
    
    var body: some View {
        let enteredTitle = Binding<String>(
            get: { self.viewModel.enteredTitle },
            set: { self.viewModel.enteredTitle = $0 }
        )
        
        let enteredPlace = Binding<String>(
            get: { self.viewModel.enteredPlace },
            set: { self.viewModel.enteredPlace = $0 }
        )
        
        VStack{
            TextField("название", text: enteredTitle)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .cornerRadius(44)
            .frame(width: 338, height: 44)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            TextField("регион", text: enteredPlace)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding()
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .cornerRadius(44)
            .frame(width: 338, height: 44)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button {
                viewModel.didTapCreateField()
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
