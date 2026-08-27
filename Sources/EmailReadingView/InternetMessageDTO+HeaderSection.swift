/// The header section for an e‑mail message.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

extension InternetMessageDTO {
  /// An ordered collection of header fields that make up the message header.
  ///
  /// `HeaderSection` preserves the order of fields as they appear in
  /// the original message,
  /// which can be significant for certain headers or for diagnostic purposes.
  ///
  /// A print-out of an instance serializes each header field to separate lines.
  /// This imitates a header section in an actual message.
  ///
  /// Conforms to:
  /// - `Sendable`: Safe to use across concurrency domains.
  /// - `RandomAccessCollection`: Provides efficient indexed access.
  /// - `Hashable`: Supports use in sets and as dictionary keys.
  /// - `Codable`: Encodable/Decodable for persistence and transport.
  /// - `CustomStringConvertible`: Joins fields into conventional header lines.
  public struct HeaderSection: Sendable {
    /// The underlying storage of header fields in their preserved order.
    let fields: [HeaderField]

    /// Creates a header section from a sequence of header fields.
    ///
    /// The order of the provided sequence is preserved.
    ///
    /// - Parameter fields: A sequence of `HeaderField` values.
    init(_ fields: some Sequence<HeaderField>) {
      self.fields = .init(fields)
    }
  }
}

extension InternetMessageDTO.HeaderSection: RandomAccessCollection {
  public var startIndex: Int { self.fields.startIndex }
  public var endIndex: Int { self.fields.endIndex }

  public func index(after i: Int) -> Int {
    return i + 1
  }
  public func index(before i: Int) -> Int {
    return i - 1
  }

  public func index(_ i: Int, offsetBy distance: Int) -> Int {
    return i + distance
  }
  public func distance(from start: Int, to end: Int) -> Int {
    return end - start
  }

  public subscript(position: Int) -> InternetMessageDTO.HeaderField {
    return self.fields[position]
  }
}

extension InternetMessageDTO.HeaderSection: ExpressibleByDictionaryLiteral {
  /// Creates a header section from a dictionary literal of name/value pairs.
  ///
  /// Example:
  /// ```swift
  /// let headers: InternetMessageDTO.HeaderSection = [
  ///   "From": "alice@example.com",
  ///   "To": "bob@example.com",
  ///   "Subject": "Hello"
  /// ]
  /// ```
  /// The order of fields in the resulting section matches the order written
  /// in the literal.
  public init(dictionaryLiteral elements: (String, String)...) {
    self.init(elements.lazy.map(InternetMessageDTO.HeaderField.init))
  }
}

extension InternetMessageDTO.HeaderSection: Hashable {}

extension InternetMessageDTO.HeaderSection: Decodable, Encodable {}

extension InternetMessageDTO.HeaderSection: CustomStringConvertible {
  /// A formatted string with one header per line, or a placeholder when empty.
  ///
  /// - If the section contains fields, each field is rendered using its
  ///   `description` and lines are joined with newline separators.
  /// - If the section is empty, the placeholder `"<<Empty Header>>"` is used.
  public var description: String {
    if self.fields.isEmpty {
      "<<Empty Header>>"
    } else {
      self.fields.map(String.init(describing:)).joined(separator: "\n")
    }
  }
}
