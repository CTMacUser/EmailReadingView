# `EmailReadingView`

A lightweight, reusable SwiftUI component designed to display e-mail messages.

## Features

- Implements the header section with a collection type lacking lookup,
  to preserve field order and any duplicated field names.
- Gracefully handles e-mail messages that may lack a body.
  (This is distinct from an empty body.)
- Leverages standard data types,
  to work with many clients using minimal data massaging.

## Installation

You can add `EmailReadingView` to your project using the Swift Package Manager.

### Using Xcode

1. Open your project in Xcode.
2. Navigate to **File** > **Add Package Dependencies...**
3. Enter the repository URL: `https://github.com/CTMacUser/EmailReadingView.git`
4. Follow the prompts to add the package to your target.

### Using Package.swift

Add the following dependency to your `dependencies` array in `Package.swift`:

```swift
.package(url: "https://github.com/CTMacUser/EmailReadingView.git", from: "0.1.0")
```

And add it to your target's `dependencies` array:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "EmailReadingView", package: "EmailReadingView"),
    ]),
```

## Usage

Initialize the view with a list of header fields and an optional body string:

```swift
import SwiftUI
import EmailReadingView

struct MyEmailView: View {
    let headers: KeyValuePairs<String, String> = [
        "From": "sender@example.com",
        "Subject": "Hello, World!"
    ]
    let content = "This is the content of the e-mail."

    var body: some View {
        EmailReadingView(header: headers, body: content)
    }
}
```

## License

This project is licensed under LGPL 2.1, with an option to use a later version.
See the [LICENSE](LICENSE) file for details.
