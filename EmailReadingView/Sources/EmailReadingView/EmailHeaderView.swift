/// A view displaying the header section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's header section.
struct EmailHeaderView: View {
  /// A type alias for the header section's lines.
  typealias Header = EmailReadingView._Header

  var body: some View {
    Text("Hello, World!")
  }

  /// The header section's lines.
  let headerLines: Header

  /// Creates an view for the given e-mail header.
  ///
  /// - Parameter header: The header key-value pairs.
  ///   An element's key is a header field name,
  ///   and its value is the corresponding field body.
  init(header: Header) {
    self.headerLines = header
  }
}

#Preview("One field") {
  EmailHeaderView(header: ["Subject": "This is a test."])
}

#Preview("Empty") {
  EmailHeaderView(header: [:])
}
