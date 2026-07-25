/// A view displaying the header section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's header section.
struct EmailHeaderView: View {
  /// A type alias for the header section's lines.
  typealias Header = EmailReadingView._Header

  /// How the message's body will be handled.
  enum BodyRole {
    /// Whether or not the message body, if any, contains characters.
    enum bodyCount {
      /// The body is empty.
      case empty
      /// The body contains at least one character.
      case nonEmpty
    }

    /// The message body is not used in this view.
    case unused
    /// The message has a `nil` body.
    case absent
    /// The message actually has a body, which may be empty.
    case present(length: bodyCount)
  }

  /// How to respond to an empty header based off the body.
  var bodyStatusText: String {
    switch self.bodyRole {
    case .unused:
      "No Header Fields"
    case .absent:
      "No Message Data"
    case .present(.empty):
      "Empty Message"
    case .present(.nonEmpty):
      "Empty Header"
    }
  }

  var body: some View {
    VStack {
      List(self.headerLines.indices, id: \.self) {
        LabeledContent(
          self.headerLines[$0].key.localizedCapitalized,
          value: self.headerLines[$0].value
        )
        .textSelection(.enabled)
      }
      .overlay {
        if self.headerLines.isEmpty {
          ContentUnavailableView {
            Text(self.bodyStatusText)
          }
        }
      }

      if case .present = self.bodyRole {
        Divider()
          .padding(.horizontal)
      }
    }
  }

  /// The header section's lines.
  let headerLines: Header
  /// How this header will treat the body.
  let bodyRole: BodyRole

  /// Creates an view for the given e-mail header.
  ///
  /// - Parameter header: The header key-value pairs.
  ///   An element's key is a header field name,
  ///   and its value is the corresponding field body.
  /// - Parameter bodyIsNil: Whether if the top-level message body is
  ///   absent (`nil`) or present (not-`nil`,
  ///   including an empty string).
  ///   This determine whether this view will display an empty-header note
  ///   (not-`nil`) or an empty-message note (`nil`).
  init(header: Header, bodyRole: BodyRole) {
    self.headerLines = header
    self.bodyRole = bodyRole
  }
}

#Preview("Empty Header and Body") {
  EmailHeaderView(header: [:], bodyRole: .present(length: .empty))
}

#Preview("Empty Header with Non-empty Body") {
  EmailHeaderView(header: [:], bodyRole: .present(length: .nonEmpty))
}

#Preview("No Data, Message Context") {
  EmailHeaderView(header: [:], bodyRole: .absent)
}

#Preview("No Data, Header-only Context") {
  EmailHeaderView(header: [:], bodyRole: .unused)
}

#Preview("One field") {
  EmailHeaderView(
    header: ["Subject": "This is a test."],
    bodyRole: .present(length: .empty)
  )
}

#Preview("Two fields") {
  EmailHeaderView(
    header: [
      "From": "gwashington@whitehouse.gov",
      "To": "jadams@whitehouse.gov",
    ],
    bodyRole: .present(length: .nonEmpty)
  )
}

#Preview("Long field body") {
  EmailHeaderView(
    header: [
      "Summary": """
      A123456789 B123456789 C123456789 \
      D123456789 E123456789 F123456789 G123456789
      """
    ],
    bodyRole: .present(length: .empty)
  )
}

#Preview("Long field body, with body divider") {
  EmailHeaderView(
    header: [
      "Summary": """
      A123456789 B123456789 C123456789 \
      D123456789 E123456789 F123456789 G123456789
      """
    ],
    bodyRole: .present(length: .nonEmpty)
  )
}

#Preview("Case-normalized Header field names") {
  EmailHeaderView(
    header: ["reference".lowercased(): "A123456789 b123456789"],
    bodyRole: .present(length: .empty)
  )
}
