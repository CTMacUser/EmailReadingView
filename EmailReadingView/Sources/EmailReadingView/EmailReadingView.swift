/// A view displaying an e-mail message.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view that displays an e-mail message, its header and body sections.
public struct EmailReadingView: View {
  /// A type alias for the storage of header lines.
  public typealias _Header = KeyValuePairs<String, String>

  public var body: some View {
    VStack {
      EmailHeaderView(header: self.headerSection)
      if let actualBody = self.bodySection {
        EmailBodyView(body: actualBody)
      }
    }
  }

  /// The header lines of the e-mail.
  public let headerSection: _Header
  /// The body content of the e-mail.
  public let bodySection: String?

  /// Creates a view for the given e-mail message.
  ///
  /// - Parameters:
  ///   - header: The header field lines.
  ///     For each line, the key is the field name,
  ///     and the value its corresponding field body.
  ///   - body: The body content of the e-mail.
  ///     Does not have to exist.
  ///     (A `nil` body is distinct from an empty body.)
  public init(header: _Header, body: String?) {
    self.headerSection = header
    self.bodySection = body
  }
}
