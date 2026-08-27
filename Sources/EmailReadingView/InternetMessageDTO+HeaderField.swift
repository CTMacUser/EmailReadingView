/// A header field from an e‑mail message.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import Foundation

extension InternetMessageDTO {
  /// A single header field within an Internet e‑mail message.
  ///
  /// `HeaderField` models a single name/value pair from the message header
  /// section (for example, `From`, `To`, `Subject`, `Date`, or custom fields).
  ///
  /// Equality compares names case‑insensitively
  /// (per common e‑mail header semantics) and bodies case‑sensitively.
  /// Hashing follows the same rule by folding the name case‑insensitively and
  /// combining it with the body.
  ///
  /// A print-out of an instance uses a `"Name: Value"` format.
  public struct HeaderField: Sendable {
    /// The field name (e.g., `From`, `Subject`, `X-Custom-Header`).
    ///
    /// Name comparisons for equality and hashing are case‑insensitive.
    let name: String

    /// The raw field value/body.
    ///
    /// The body is compared case‑sensitively for equality and hashing.
    let body: String

    /// Creates a header field with the given name and body.
    ///
    /// - Parameters:
    ///   - name: The header field name.
    ///     Case is preserved but not considered for equality or hashing.
    ///   - body: The header field value/body.
    init(name: String, body: String) {
      self.name = name
      self.body = body
    }
  }
}

extension InternetMessageDTO.HeaderField {
  /// Convenience initializer from a `(key: value:)` pair.
  ///
  /// - Parameter pair: A tuple whose `key` maps to `name` and `value` maps to
  ///   `body`.
  public init(_ pair: (key: String, value: String)) {
    self.init(name: pair.key, body: pair.value)
  }
}

extension InternetMessageDTO.HeaderField: Hashable {
  /// Returns `true` when both fields have equal bodies and their names are
  /// equal under case‑insensitive comparison.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    guard lhs.body == rhs.body else { return false }

    return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
  }

  /// Hashes the field by combining a case‑insensitive canonical form of
  /// `name` with the exact `body`.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(
      self.name.decomposedStringWithCanonicalMapping.folding(
        options: [.caseInsensitive],
        locale: nil
      )
    )
    hasher.combine(self.body)
  }
}

extension InternetMessageDTO.HeaderField: Decodable, Encodable {}

extension InternetMessageDTO.HeaderField: CustomStringConvertible {
  /// A conventional header line formatted as `"Name: Value"`.
  public var description: String { "\(self.name): \(self.body)" }
}
