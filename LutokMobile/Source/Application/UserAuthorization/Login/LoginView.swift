//
//  LoginView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 29.03.2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @ObservedObject
    var viewModel: LoginViewModel
    
    var body: some View {
        
        let enteredSignInEmail = Binding<String>(
            get: { self.viewModel.enteredSignInEmail },
            set: { self.viewModel.enteredSignInEmail = $0 }
        )
        
        let enteredRegisterEmail = Binding<String>(
            get: { self.viewModel.enteredRegisterEmail },
            set: { self.viewModel.enteredRegisterEmail = $0 }
        )
        
        let enteredSignInPassword = Binding<String>(
            get: { self.viewModel.enteredSignInPassword },
            set: { self.viewModel.enteredSignInPassword = $0 }
        )
        
        let enteredRegisterPassword = Binding<String>(
            get: { self.viewModel.enteredRegisterPassword },
            set: { self.viewModel.enteredRegisterPassword = $0 }
        )
        
        let enteredRepeatedPassword = Binding<String>(
            get: { self.viewModel.enteredPasswordConfirmation },
            set: { self.viewModel.enteredPasswordConfirmation = $0 }
        )
        
        VStack(alignment: .center, spacing: 8.0) {
            Image("A_Logo")
                .padding(.bottom, 32)
            Text("Войти в аккаунт")
                .font(.system(size: 32))
                .padding(.bottom, 8)
            HStack(alignment: .center, spacing: 12.0) {
                Button {
                    viewModel.currentTab = .signUp
                } label: {
                    Spacer()
                    Text("Регистрация")
                        .frame(width: 166, height: 28, alignment: .center)
                        .foregroundColor(.black)
                    
                }   .background( viewModel.currentTab == .signUp ? Color.white : Color(red: 242/255, green: 242/255, blue: 247/255) )
                    .frame(width: 166, height: 32)
                    .cornerRadius(14)
//                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)

                Button {
                    viewModel.currentTab = .login
                } label: {
                    Spacer()
                    Text("Вход")
                        .frame(width: 166, height: 28, alignment: .center)
                        .foregroundColor(.black)
                    
                }   .background( viewModel.currentTab == .login ? Color.white : Color(red: 242/255, green: 242/255, blue: 247/255) )
                    .frame(width: 166, height: 28)
                    .cornerRadius(14)
//                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)

            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))
            .frame(width: 338.0, height: 32.0)
            .cornerRadius(16)
            .padding(.bottom, 72)
            
            if viewModel.currentTab == .login {
                VStack(spacing: 8){
                    
                    TextField("Email", text: enteredSignInEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                        .cornerRadius(44)
                        .frame(width: 338, height: 44)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    TextField("Пароль", text: enteredSignInPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                        .cornerRadius(44)
                        .frame(width: 338, height: 44)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    Button {
                        viewModel.didTapLogin()
                    } label: {
                        Text("Войти")
                            .frame(width: 338, height: 44)
                            .background(Color(red: 23/255, green: 193/255, blue: 251/255))
                            .foregroundColor(.white)
                            .cornerRadius(44)
                            .padding(.vertical, 32)
                    }
                    
                    Text("Забыли пароль? Восстановить")
                }
            } else {
                VStack(spacing: 8){
                    TextField("Email", text: enteredRegisterEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                        .cornerRadius(44)
                        .frame(width: 338, height: 44)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    TextField("Пароль", text: enteredRegisterPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                        .cornerRadius(44)
                        .frame(width: 338, height: 44)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    TextField("Повторите пароль", text: enteredRepeatedPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                        .cornerRadius(44)
                        .frame(width: 338, height: 44)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    Button {
                        viewModel.didTapRegister()
                    } label:{
                        Text("Зарегистрироваться")
                            .frame(width: 338, height: 44)
                            .background(Color(red: 23/255, green: 193/255, blue: 251/255))
                            .foregroundColor(.white)
                            .cornerRadius(44)
                            .padding(.vertical, 32)
                    }
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 120.0, leading: 12.0, bottom: 0.0, trailing: 12.0))
    }
}
