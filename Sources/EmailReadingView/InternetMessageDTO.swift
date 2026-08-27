/// A data-transfer object for an e-mail message.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

/// A data-transfer object representing an Internet e‑mail message.
///
/// `InternetMessageDTO` is a simple, value‑type container suitable for
/// serialization and transport (e.g., across processes or networks).
/// It holds the parsed header section and an optional textual body.
public struct InternetMessageDTO: Sendable {
  /// The structured header section of the message.
  ///
  /// Typically includes fields like `From`, `To`, `Subject`, `Date`,
  /// and any custom headers supported by the message format.
  public let header: HeaderSection

  /// The optional body of the message as plain text.
  ///
  /// `nil` is used when the message has no body.
  public let body: String?

  /// Creates a new message DTO with the provided header and optional body.
  ///
  /// - Parameters:
  ///   - header: The header section of the message.
  ///   - body: The message body as plain text, or `nil` if absent.
  public init(header: HeaderSection, body: String?) {
    self.header = header
    self.body = body
  }
}

extension InternetMessageDTO: Hashable {}

extension InternetMessageDTO: Decodable, Encodable {}

extension InternetMessageDTO: CustomStringConvertible {
  /// A formatted string that concatenates the header and body in
  /// conventional e‑mail format.
  ///
  /// The representation prints the header first, followed by a blank line,
  /// and then the body (if present).
  /// If `body` is `nil`, only the header is printed.
  public var description: String {
    var result = ""
    print(self.header, to: &result)
    if let bodyText = self.body {
      print(to: &result)
      print(bodyText, to: &result)
    }
    return result
  }
}
