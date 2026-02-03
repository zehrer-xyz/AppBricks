# AppBricks

AppBricks is an open-source foundation for building high-quality SwiftUI
applications in a repeatable, structured, and maintainable way.

It provides a small runtime and a set of composable building blocks that help
industrialize app development without hiding Swift or SwiftUI.

AppBricks is designed to work with:
- SwiftUI
- Swift Package Manager
- Explicit dependency injection
- Modular feature packages
- iOS first, macOS later

---

## Motivation

Modern app development is fast, but architectural quality often degrades as
each new project reinvents the same foundations.

AI-assisted coding accelerates this even further, but without strong
constraints it amplifies inconsistency and technical debt.

AppBricks aims to provide a stable, understandable baseline so developers can
focus on domain-specific problems instead of rebuilding infrastructure.

---

## Key Principles

- Explicit over implicit behavior
- Composition over inheritance
- Dependency injection as a first-class concept
- Testability by design
- Clear boundaries between features and infrastructure
- Refactoring-friendly architecture

---

## Project Structure (typical)

AppBricks/
├─ Packages/
│  ├─ AppBricksCore
│  ├─ AppBricksUI
│  └─ Features/
├─ DemoApps/
├─ docs/
└─ README.md


DemoApps are examples only and are not required for using AppBricks.

---

## Usage

The typical workflow is:
1. Create a new iOS or macOS project using Xcode
2. Add AppBricks packages via Swift Package Manager
3. Use AppBricks-provided root views and services
4. Assemble features in your application shell

No project templates are required.

---

## License

AppBricks is **dual-licensed**:

- **GPLv3** for open-source projects
- **Commercial license** required for proprietary or closed-source use

If you intend to use AppBricks in a commercial, closed-source, or proprietary
application, you must obtain a commercial license.

For commercial licensing inquiries, please contact the project maintainer.

See the `LICENSE` file for details.

---

## Contributing

Contributions are welcome.

Please note that due to the dual-licensing model, contributors may be required
to agree to a Contributor License Agreement (CLA).

More details please contact the project maintainer.

---

## Status

AppBricks is in early development.
APIs and architecture may evolve until the first stable release.
