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
      EmailHeaderView(
        header: self.headerSection,
        bodyRole: self.isHeaderOnly
          ? .unused
          : self.bodySection.map {
            .present(length: $0.isEmpty ? .empty : .nonEmpty)
          } ?? .absent
      )

      if let actualBody = self.bodySection,
        !actualBody.isEmpty || !self.headerSection.isEmpty
      {
        EmailBodyView(body: actualBody)
      }
    }
  }

  /// The header lines of the e-mail.
  public let headerSection: _Header
  /// The body content of the e-mail.
  public let bodySection: String?
  /// Whether this view is for a full message or only header data.
  let isHeaderOnly: Bool

  /// Creates a view for the given message header section.
  ///
  /// This is for data sources that are defined to be just a header.
  ///
  /// - Parameter onlyHeader: The header field lines.
  ///   For each line, the key is the field name,
  ///   and the value its corresponding field body.
  public init(onlyHeader: _Header) {
    self.headerSection = onlyHeader
    self.bodySection = nil
    self.isHeaderOnly = true
  }
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
    self.isHeaderOnly = false
  }
}

#Preview("Header-only: empty") {
  EmailReadingView(onlyHeader: [:])
}

#Preview("Header-only: not empty") {
  EmailReadingView(onlyHeader: ["Summary": "Is this a test?"])
}

#Preview("Message: empty header, no body (i.e. no actual data)") {
  EmailReadingView(header: [:], body: nil)
}

#Preview("Message: empty header, empty body") {
  EmailReadingView(header: [:], body: "")
}

#Preview("Message: empty header, non-empty body") {
  EmailReadingView(header: [:], body: "Hello, World!")
}

#Preview("Message: non-empty header, no body") {
  EmailReadingView(header: ["Subject": "This is a test."], body: nil)
}

#Preview("Message: non-empty header, empty body") {
  EmailReadingView(header: ["Subject": "This is not a test."], body: "")
}

#Preview("Message: non-empty header, non-empty body") {
  EmailReadingView(
    header: ["From": "tjefferson@whitehouse.gov"],
    body: "This is a message."
  )
}
