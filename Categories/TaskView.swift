//
//  TaskView.swift
//  Categories
//
//  Created by Nouf Faisal  on 19/10/1445 AH.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject private var firebaseManger: FirebaseManger
    @State var isShowingAddItemView: Bool = false
    let category: Category

    var body: some View {
        NavigationStack {
            List {
                ForEach(firebaseManger.items, id: \.id) { item in
                    NavigationLink {
                        UpdateItemView(item: item, category: category)
                    } label: {
                        VStack {
                            Text(item.title)
                            Text(item.info)
                            Text(item.isDone.description)
                            Text(item.id)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            Task {
                                try await firebaseManger.deleteItem(item, category)
                                try? await firebaseManger.fetchItems(category)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }.tint(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddItemView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            try await firebaseManger.fetchItems(category)
                        }
                    } label: {
                        Text("Fetch from DB")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddItemView) {
                NavigationStack {
                    AddItemView(category: category)
                }
            }
            .onAppear {
                Task {
                    try await firebaseManger.fetchItems(category)
                }
            }
        }
    }
}


