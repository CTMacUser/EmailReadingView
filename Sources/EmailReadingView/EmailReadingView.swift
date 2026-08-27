/// A view displaying an e-mail message.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view that displays an e-mail message, its header and body sections.
public struct EmailReadingView: View {
  /// The message to be displayed.
  let message: InternetMessageDTO
  /// A cache of the visual mode to use.
  let topLevelNotice: Text?

  public var body: some View {
    VSplitView {
      EmailHeaderView(header: self.message.header)
      if let bodyString = self.message.body {
        EmailBodyView(body: bodyString)
      }
    }
    .opacity(topLevelNotice == nil ? 1 : 0)
    .overlay {
      if let topLevelNotice {
        ContentUnavailableView {
          topLevelNotice
        }
      }
    }
  }

  /// Creates a view of the given message.
  init(_ message: InternetMessageDTO) {
    self.message = message
    self.topLevelNotice =
      if message.header.isEmpty {
        switch message.body?.isEmpty {
        case true:
          Text(
            "MESSAGE_EMPTY",
            bundle: #bundle,
            comment: "Empty header with an empty-string body."
          )
        case false:
          nil
        case nil:
          Text(
            "MESSAGE_MISSING",
            bundle: #bundle,
            comment: "Empty header during NIL body."
          )
        }
      } else {
        nil
      }
  }
}

let emptyHeaderNilBody = InternetMessageDTO(header: [:], body: nil)
#Preview("Empty header, NIL body (i.e. no actual data)") {
  EmailReadingView(emptyHeaderNilBody)
}

let fullHeaderNilBody = InternetMessageDTO(
  header: ["Summary": "Is this a test?"],
  body: nil
)
#Preview("Nonempty header, NIL body (i.e. header-only)") {
  EmailReadingView(fullHeaderNilBody)
}

let emptyHeaderEmptyBody = InternetMessageDTO(header: [:], body: "")
#Preview("Empty header, empty body (i.e. blank data)") {
  EmailReadingView(emptyHeaderEmptyBody)
}

let fullHeaderEmptyBody = InternetMessageDTO(
  header: ["Subject": "This is not a test."],
  body: ""
)
#Preview("Nonempty header, empty body") {
  EmailReadingView(fullHeaderEmptyBody)
}

let emptyHeaderFullBody = InternetMessageDTO(header: [:], body: "Hello, World!")
#Preview("Empty header, nonempty body") {
  EmailReadingView(emptyHeaderFullBody)
}

let fullHeaderFullBody = InternetMessageDTO(
  header: ["From": "tjefferson@whitehouse.gov"],
  body: "This is a message."
)
#Preview("Nonempty header, nonempty body") {
  EmailReadingView(fullHeaderFullBody)
}

let emptyHeaderSpacedBody = InternetMessageDTO(header: [:], body: "  \r\n\t ")
#Preview("Empty header, whitespace-only body") {
  EmailReadingView(emptyHeaderSpacedBody)
}

let fullHeaderSpacedBody = InternetMessageDTO(
  header: ["Summary": "This is a test."],
  body: "\r\n \t  "
)
#Preview("Nonempty header, whitespace-only body") {
  EmailReadingView(fullHeaderSpacedBody)
}
