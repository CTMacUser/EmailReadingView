/// A view displaying the body section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's body.
struct EmailBodyView: View {
  var body: some View {
    // Can't adjust the internal padding of "TextEditor" because its
    // existing API, "contentMargins," is bugged.
    // Add it when it's fixed.
    TextEditor(text: .constant(self.value))
      .accessibilityLabel("Body")
      .textEditorStyle(.plain)
      .monospaced()
      .overlay {
        if self.value.isEmpty {
          ContentUnavailableView {
            Text("No Text")
          }
        } else if self.value.allSatisfy(\.isWhitespace) {
          ContentUnavailableView {
            Text("Only Whitespace")
          } description: {
            Text("Character selection is still enabled.")
          }
          .allowsHitTesting(false)
        }
      }
  }

  /// Creates a view for the given e-mail body.
  ///
  /// - Parameter body: The text content of the e-mail body.
  init(body: String) {
    self.value = body
  }

  /// The text content of the e-mail body.
  let value: String
}

#Preview("Visible characters") {
  EmailBodyView(body: "Hello, World!")
}

#Preview("Empty string") {
  EmailBodyView(body: "")
}

#Preview("Only white-space") {
  EmailBodyView(body: "\t \r\n")
}
