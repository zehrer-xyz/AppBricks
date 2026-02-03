//
//  Copyright (c) 2026 zehrer.xyz
//  Author: Stephan Zehrer
//
//  This file is part of AppBricks.
//
//  AppBricks is dual-licensed:
//  - GPLv3 for open-source use
//  - Commercial license required for proprietary use
//
// SPDX-License-Identifier: GPL-3.0-only
//
//  See the LICENSE file for details.
//
//  ContentListView.swift
//


import SwiftUI
import SwiftData

protocol Item: Identifiable {
    var id: Self.ID { get }
    var name: String { get }
}

protocol ItemList {
    associatedtype Element: Item
    var items: [Element] { get set }
    func addItem()
    func deleteItems(offsets: IndexSet)
}

struct ContentListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Tag]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        //Details
                        Text("Tag: \(item.name)")
                    } label: {
                        //List Label
                        Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Tag("#NewTag")!
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}



#Preview {
    ContentListView()
        .modelContainer(for: Tag.self, inMemory: true)
}
