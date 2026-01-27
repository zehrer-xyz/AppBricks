# ADR-0001: Dependency Injection Strategy

Decision:
We use an explicit AppEnvironment struct passed into features.

Status:
Accepted

Rationale:
- Testability
- No global singletons
- Simplicity for v1.0
