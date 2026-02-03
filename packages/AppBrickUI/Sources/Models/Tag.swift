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
//  Tag.swift
//

import Foundation
import SwiftData

import SwiftUI

extension String {
    var containsLetter: Bool {
        // Uses Unicode categories; covers a–z, A–Z and other alphabets
        return self.unicodeScalars.contains { CharacterSet.letters.contains($0) }
    }
}

// the tag concept is aligned to what apple at the moment implement in the appes Notes and Files.
// The name is storted without hastag
@Model
final class Tag {
    var name: String  // storing name without hastag
    var createDate: Date?
    // Persist enum via raw value to avoid @Model dependency
    var simpleColorRaw: UInt8? // persisted raw value for SimpleColor
    var simpleColor: SimpleColor? {
        get {
            guard let raw = simpleColorRaw else { return nil }
            return SimpleColor(rawValue: raw)
        }
        set {
            simpleColorRaw = newValue?.rawValue
        }
    }
    
    init?(_ raw: String) {
        guard let normalized = Tag.normalizedTagName(from: raw) else { return nil }
        self.name = normalized
        self.createDate = Date()
        self.simpleColorRaw = nil
    }
    
    func normalizeTagInput(_ raw: String) -> String {
          raw.trimmingCharacters(in: .whitespacesAndNewlines)
             .replacingOccurrences(of: "\u{FE0F}", with: "") // strip emoji variation selectors if needed
             .drop(while: { $0 == "#" })
             .reduce(into: "") { $0.append($1) }
    }
    
    static func normalizedTagName(from raw: String) -> String? {
        let base = raw
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\u{FE0F}", with: "")
            .drop(while: { $0 == "#" })

        let name = String(base)

        // Optional: collapse internal whitespace or enforce allowed charset
        // e.g., keep letters, numbers, underscore, hyphen:
        // let allowed = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_-"))
        // let filtered = name.unicodeScalars.filter { allowed.contains($0) }
        // let final = String(String.UnicodeScalarView(filtered))

        // Require at least one letter (to mimic Notes)
        guard name.containsLetter else { return nil }

        // Optional: lowercase for canonicalization
        return name
    }
}

