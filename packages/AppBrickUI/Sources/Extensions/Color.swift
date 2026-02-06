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
//  Color.swift
//

import SwiftUI

enum SimpleColor: UInt8, CaseIterable, Identifiable {

    case none   = 0
    case red    = 1
    case orange = 2
    case yellow = 3
    case green  = 4
    case blue   = 5
    case purple = 6
    case gray   = 7
    
    
    var id: UInt8 { rawValue }
    
    var color: Color? {
        switch self {
        case .none:    nil
        case .red:    .red
        case .orange: .orange
        case .yellow: .yellow
        case .green:  .green
        case .blue:   .blue
        case .purple: .purple
        case .gray:   .gray
        }
    }
    
    static func labelName(_ label: SimpleColor) -> LocalizedStringKey {
        switch label {
        case .none:  "color.none"
        case .red:    "color.red"
        case .orange: "color.orange"
        case .yellow: "color.yellow"
        case .green:  "color.green"
        case .blue:   "color.blue"
        case .purple: "color.purple"
        case .gray:   "color.gray"
        }
    }
}

extension Color {

    static func labelName(_ label: Color) -> LocalizedStringKey {
        switch label {
        case .red:    "color.red"
        case .orange: "color.orange"
        case .yellow: "color.yellow"
        case .green:  "color.green"
        case .blue:   "color.blue"
        case .purple: "color.purple"
        case .gray:   "color.gray"
        case .black:  "color.black"
        case .white:  "color.white"
        case .cyan:   "color.cyan"
        case .brown:  "color.brown"
        case .indigo: "color.indigo"
        case .pink:   "color.pink"
        case .mint:   "color.mint"
        case .teal:   "color.teal"
        case .clear:  "color.clear"
        default:
            "color.unknown"
        }
    }
}
