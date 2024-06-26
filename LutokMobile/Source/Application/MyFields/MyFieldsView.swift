//
//  MyFieldsView.swift
//  LutokMobile
//
//  Created by Maria Vanurina on 29.03.2024.
//

import Foundation
import SwiftUI

struct MyFieldsView: View {
    
    var service: MyFieldsService = MyFieldsService()
    
    private var profileIsPresentedBinding: Binding<Bool>
    private var newFieldIsPresentedBinding: Binding<Bool>
    
    init(
        profileIsPresentedBinding: Binding<Bool>,
        newFieldIsPresentedBinding: Binding<Bool>,
        viewModel: MyFieldsViewModel)
    {
        self.profileIsPresentedBinding = profileIsPresentedBinding
        self.newFieldIsPresentedBinding = newFieldIsPresentedBinding
        
        self.viewModel = viewModel
        
//        let appearance = UINavigationBarAppearance()
//                appearance.configureWithOpaqueBackground()
//                appearance.backgroundColor = UIColor.systemBackground
//                appearance.titleTextAttributes = [
//                    .foregroundColor: Color(red: 33/255, green: 33/255, blue: 33/255),
//                    .font: UIFont.systemFont(ofSize: 24, weight: .bold)
//                ]
//                
//                UINavigationBar.appearance().standardAppearance = appearance
//                UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @ObservedObject
    var viewModel: MyFieldsViewModel
    
    
    @State
    var isFieldActive: Bool = false
    
    @State
    var fieldIdSelected: Int? = nil
    
    @State
    var items: [MyFieldListItemViewModel] = []
    
    var body: some View {
        //VStack {
        
        NavigationView {
            VStack {
                NavigationLink(destination: NotesView(viewModel: NotesViewModel(id: fieldIdSelected ?? -1), newFiledIsPresented: false), isActive: $isFieldActive) { EmptyView() }
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                List {
                    ForEach(items) { item in
                        MyFieldListItemView(model: item)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .background(Color.clear)
                            .frame(width: 344, height: 100)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 251/255, blue: 255/255))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .gesture(TapGesture().onEnded({ _ in
                                print(item.id)
                                self.fieldIdSelected = item.id
                                self.isFieldActive = true
                            }))
                    }
                }
                .listStyle(.plain)
                .background(Color.white)
    
                VStack{
                    Spacer()
                    Button{
                        viewModel.activeSheet = .newField
                    } label: {
                        Image(systemName: "plus")
                                            .font(.system(size: 36, weight: .bold))
                                            .foregroundColor(.white)
                    }
                    .frame(width: 74, height: 74)
                                .background(Color(red: 23/255, green: 193/255, blue: 251/255))
                                .clipShape(Circle())
                                .shadow(radius: 10)
                }
            }
        }
            .navigationTitle("Мои поля")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.viewModel.activeSheet = .profile
                    } label: {
                        Image(systemName: "person.crop.circle")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(red: 23/255, green: 193/255, blue: 251/255))
                    }
                }
            }
        }
        .background(Color.clear)
        .onAppear(perform: {
            onAppear()
//            viewModel.onAppear()
            UITableView.appearance().backgroundColor = .clear
                            UITableViewCell.appearance().backgroundColor = .clear
        })
        .sheet(item: viewModel.activeSheetBindings) { item in
            switch item {
            case .newField:
                NewFieldView(viewModel: NewFieldViewModel(service: MyFieldsService(), onDismiss: {
                    DispatchQueue.main.async {
                        self.viewModel.activeSheet = nil
                        self.onAppear()
                    }
                }))
            case .profile:
                ProfileView(
                    viewModel: ProfileViewModel(
                        profileIsPresentedBinding: profileIsPresentedBinding,
                        delegate: viewModel
                    ))
            }
        }
    }
    
    func onAppear(){
        service.loadFields { result in
            switch result {
            case .success(let model):
                self.items = model.map {
                    MyFieldListItemViewModel(
                        title: $0.title,
                        place: $0.place,
                        id: $0.id
                    ) }
                print(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {

    @Binding var isPresented: Bool

    static var viewModel = MyFieldsViewModel(navigationBinding: .constant(.myFields))

    static var previews: some View {
        MyFieldsView(profileIsPresentedBinding: .constant(false), newFieldIsPresentedBinding: .constant(false), viewModel: viewModel)
    }
}
