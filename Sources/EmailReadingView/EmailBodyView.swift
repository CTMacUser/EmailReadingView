/// A view displaying the body section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's body.
struct EmailBodyView: View {
  var body: some View {
    Divider()
      .padding()

    // Can't adjust the internal padding of "TextEditor" because its
    // existing API, "contentMargins," is bugged.
    // Add it when it's fixed.
    TextEditor(text: .constant(self.value))
      .accessibilityLabel(
        LocalizedStringResource(
          "BODY_LABEL",
          bundle: #bundle,
          comment: "The (VoiceOver) label for the body's contents."
        )
      )
      .textEditorStyle(.plain)
      .monospaced()
      .overlay {
        if self.value.isEmpty {
          ContentUnavailableView {
            Text(
              "BODY_ZERO_CHARACTERS",
              bundle: #bundle,
              comment: "Indicates that the body string has no elements."
            )
          }
        } else if !self.isPrintable {
          ContentUnavailableView {
            Text(
              "BODY_NO_GRAPHIC_CHARACTERS",
              bundle: #bundle,
              comment:
                "Indicates that the body string has no graphic characters."
            )
          } description: {
            Text(
              "BODY_SELECT_MESSAGE",
              bundle: #bundle,
              comment:
                "Reminder that non-zero spacing characters can still be selected."
            )
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
    self.isPrintable = !body.unicodeScalars.allSatisfy(Self.nonGraphic.contains)
  }

  /// The text content of the e-mail body.
  let value: String
  /// Whether the content has at least one printable character.
  ///
  /// This caches a potentially long calculation.
  let isPrintable: Bool

  /// Codepoints for non-graphic (*i.e.* spacing or control) characters.
  static let nonGraphic: CharacterSet = {
    let unofficalSpaces = [0x180E, 0x200B, 0x200C, 0x200D, 0x2060, 0xFEFF]
      .compactMap(UnicodeScalar.init)
    var result = CharacterSet(unofficalSpaces)
    result.formUnion(.whitespacesAndNewlines)
    result.formUnion(.controlCharacters)
    return result
  }()
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
