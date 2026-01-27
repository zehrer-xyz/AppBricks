# AppBricks Architecture

## Layers
- Target App (iOS)
- Feature Packages
- Core Packages

## Dependency Rules
- Features depend on Core
- Core never depends on Features
- Host wires everything together
