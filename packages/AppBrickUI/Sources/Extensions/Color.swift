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

    case red    = 0
    case orange = 1
    case yellow = 2
    case green  = 3
    case blue   = 4
    case purple = 5
    case gray   = 6

    
    var id: UInt8 { rawValue }
    
    var color: Color? {
        switch self {
        case .red:    .red
        case .orange: .orange
        case .yellow: .yellow
        case .green:  .green
        case .blue:   .blue
        case .purple: .purple
        case .gray:   .gray
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
            "color.unknow"
        }
    }
}
