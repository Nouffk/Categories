//
//  UpdateCategory.swift
//  Categories
//
//  Created by Nouf Faisal  on 19/10/1445 AH.
//

import SwiftUI

struct updateCategory: View {
    @State private var categoryTitle = ""
    var category: Category
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var firebaseManger: FirebaseManger
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Category" , text: $categoryTitle)
            }
            
            Section() {
                Button("Update Category") {
                    let cat = Category(id: category.id, name: categoryTitle)
                    Task {
                        firebaseManger.updateCategory(cat)
                        try? await firebaseManger.fetchCategories()
                    }
                    dismiss()
                    
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Update Category")
            .onAppear {
                categoryTitle = category.name
                
            }
        }
    }
}

#Preview {
    updateCategory(category: Category(id: "", name: ""))
}

