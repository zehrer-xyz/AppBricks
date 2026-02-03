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
//  AppEnvironment.swift
//

import os

public struct AppEnvironment: Sendable {
  public let logger: Logger

  public init(logger: Logger) {
    self.logger = logger
  }
}

public extension AppEnvironment {
  static func live(
    subsystem: String,
    category: String = "App"
  ) -> AppEnvironment {
    .init(logger: Logger(subsystem: subsystem, category: category))
  }
}
