/// A view displaying the body section of an e-mail.
//
// SPDX-FileCopyrightText: © 2026 Daryle Walker (@CTMacUser)
// SPDX-License-Identifier: LGPL-2.1-or-later

import SwiftUI

/// A view for an e-mail message's body.
struct EmailBodyView: View {
  var body: some View {
    Text(value)
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

#Preview {
  EmailBodyView(body: "Hello, World!")
}
