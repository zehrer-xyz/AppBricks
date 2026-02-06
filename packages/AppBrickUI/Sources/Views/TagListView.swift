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
//  SwiftUIView.swift
//

import SwiftUI
import SwiftData

// MARK: - TagListView

struct TagListView: View {
    // External selection binding for multi-select usage
    @Binding var selection: Set<Tag>

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Tag.name, order: .forward)])
    private var tags: [Tag]

    @State private var newTagName: String = ""
    @State private var newTagColor: SimpleColor = .none

    var allowsMultipleSelection: Bool = true

    init(selection: Binding<Set<Tag>> = .constant([]), allowsMultipleSelection: Bool = true) {
        self._selection = selection
        self.allowsMultipleSelection = allowsMultipleSelection
    }

    var body: some View {
        List {
            Section(header: Text("tags.header")) {
                ForEach(tags) { tag in
                    Button(action: { toggleSelection(for: tag) }) {
                        HStack(spacing: 12) {
                            selectionIndicator(isSelected: isSelected(tag))
                            Text(tag.name)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                            colorDot(for: tag)
                        }
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(Text(tag.name))
                    .accessibilityValue(Text(isSelected(tag) ? "tags.accessibility.selected" : "tags.accessibility.not_selected"))
                }
            }

            Section(footer: Text("tags.footer.add_new")) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.green)
                        TextField("tags.placeholder.name", text: $newTagName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled(false)
                    }

                    HStack {
                        Menu {
                            Picker("tags.picker.color", selection: $newTagColor) {
                                ForEach(SimpleColor.allCases) { option in
                                    HStack {
                                        Circle()
                                            .fill(option.color ?? .secondary.opacity(0.3))
                                            .frame(width: 12, height: 12)
                                        Text(SimpleColor.labelName(option))
                                    }
                                    .tag(option)
                                }
                            }
                        } label: {
                            HStack {
                                Circle()
                                    .fill(newTagColor.color ?? .secondary.opacity(0.3))
                                    .frame(width: 16, height: 16)
                                Text(SimpleColor.labelName(newTagColor))
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial, in: Capsule())
                        }

                        Spacer()

                        Button(action: addNewTag) {
                            Label("tags.button.add_new", systemImage: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!canAddNewTag)
                        .accessibilityHint(Text("tags.accessibility.hint.create"))
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle(Text("tags.title"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) { dismiss() } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button { dismiss() } label: {
                    Image(systemName: "checkmark.circle.fill")
                }
                .disabled(false)
            }
        }
    }

    // MARK: - Selection helpers

    private func isSelected(_ tag: Tag) -> Bool {
        selection.contains(where: { $0.persistentModelID == tag.persistentModelID })
    }

    private func toggleSelection(for tag: Tag) {
        if allowsMultipleSelection {
            if let existing = selection.first(where: { $0.persistentModelID == tag.persistentModelID }) {
                selection.remove(existing)
            } else {
                selection.insert(tag)
            }
        } else {
            selection.removeAll()
            selection.insert(tag)
        }
    }

    // MARK: - Add new tag

    private var canAddNewTag: Bool {
        let trimmed = newTagName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        return !tags.contains(where: { $0.name.lowercased() == trimmed.lowercased() })
    }

    private func addNewTag() {
        let trimmed = newTagName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !tags.contains(where: { $0.name.lowercased() == trimmed.lowercased() }) else { return }

        guard let tag = Tag(trimmed) else { return }
        tag.simpleColor = newTagColor == .none ? nil : newTagColor
        modelContext.insert(tag)

        // Select the newly created tag
        selection.insert(tag)

        // Reset inputs
        newTagName = ""
        newTagColor = .none
    }

    // MARK: - UI bits

    @ViewBuilder
    private func selectionIndicator(isSelected: Bool) -> some View {
        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .foregroundStyle(isSelected ? Color.accentColor : .secondary)
    }

    @ViewBuilder
    private func colorDot(for tag: Tag) -> some View {
        let fill: Color = tag.simpleColor?.color ?? Color.secondary.opacity(0.3)
        Circle()
            .fill(fill)
            .frame(width: 16, height: 16)
    }
}

// MARK: - Preview

#Preview("With sample tags") {
    // Create an in-memory container and seed some tags
    let container = try! ModelContainer(for: Tag.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext

    let samples: [(String, SimpleColor)] = [
        ("Home", .blue),
        ("Work", .red),
        ("Important", .yellow),
        ("Finance", .green),
        ("Ideas", .purple),
        ("GrayTag", .gray)
    ]

    for (name, color) in samples {
        if let tag = Tag(name) {
            tag.simpleColor = color
            context.insert(tag)
        }
    }

    return NavigationStack {
        TagListView()
    }
    .modelContainer(container)
}

