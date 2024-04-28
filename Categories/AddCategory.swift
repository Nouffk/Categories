//
//  AddCategory.swift
//  Categories
//
//  Created by Nouf Faisal  on 19/10/1445 AH.
//

import SwiftUI

struct AddCategory: View {
    @State private var categoryTitle = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var firebaseManger: FirebaseManger
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Category" , text: $categoryTitle)
            }
            .padding()
            Section() {
                Button("Add Category") {
                    let cat = Category(id: UUID().uuidString, name: categoryTitle)
                    Task {
                        try await firebaseManger.createCategory(cat)
                        try? await firebaseManger.fetchCategories()
                    }
                    dismiss()
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .navigationTitle("Add Category")
        }
    }
}

#Preview {
    AddCategory()
}

