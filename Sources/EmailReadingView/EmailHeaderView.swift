/// A view displaying the header section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's header section.
struct EmailHeaderView: View {
  var body: some View {
    VStack {
      List(self.headerLines.indices, id: \.self) {
        LabeledContent(
          self.headerLines[$0].name.localizedCapitalized,
          value: self.headerLines[$0].body
        )
        .textSelection(.enabled)
      }
      .overlay {
        if self.headerLines.isEmpty {
          ContentUnavailableView {
            Text("HEADER_EMPTY", bundle: #bundle, comment: "Empty header")
          }
        }
      }
    }
  }

  /// A type alias for the header section's lines.
  typealias Header = InternetMessageDTO.HeaderSection

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

#Preview("Empty Header") {
  EmailHeaderView(header: [:])
}

#Preview("One field") {
  EmailHeaderView(
    header: ["Subject": "This is a test."]
  )
}

#Preview("Two fields") {
  EmailHeaderView(
    header: [
      "From": "gwashington@whitehouse.gov",
      "To": "jadams@whitehouse.gov",
    ]
  )
}

#Preview("Long field body") {
  EmailHeaderView(
    header: [
      "Summary": """
      A123456789 B123456789 C123456789 \
      D123456789 E123456789 F123456789 G123456789
      """
    ]
  )
}

#Preview("Case-normalized Header field names") {
  EmailHeaderView(
    header: ["rEFErENCE".lowercased(): "A123456789 b123456789"]
  )
}
