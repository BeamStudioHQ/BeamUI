[![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square)](https://raw.githubusercontent.com/Beam-Studio/BeamUI/main/LICENSE)
[![Swift 5.9 supported](https://img.shields.io/badge/Swift-5.9-orange.svg?style=flat-square)](https://github.com/apple/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://swift.org/package-manager/)

![Supports iOS 15+](https://img.shields.io/badge/iOS-15+-dc9656.svg?style=flat-square)
![Supports macOS 12+](https://img.shields.io/badge/macOS-12+-a1b56c.svg?style=flat-square)
![Supports watchOS 8+](https://img.shields.io/badge/watchOS-8+-86c1b9.svg?style=flat-square)
![Supports tvOS 15+](https://img.shields.io/badge/tvOS-15+-7cafc2.svg?style=flat-square)

# BeamUI
> a collection of SwiftUI components and utils

## Installation

To install BeamUI you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)
using the URL for the BeamUI repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/Beam-Studio/BeamUI.git

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/Beam-Studio/BeamUI.git", from: "main")
```

## Components

### Marquee
An infinitely self-scrolling container.

<img src="https://github.com/Beam-Studio/BeamUI/assets/5302918/2f28c952-e2d9-4831-80c2-5a5d2b59b469" width=320>

#### Usage
```swift
Marquee(velocity: 20, spacing: 20) {
    Text(verbatim: "This is some infinitely scrolling text")
    Text(verbatim: "Here is another text because why not?")
}
```

#### Inspired by
- [Supersonic](https://apps.apple.com/us/app/supersonic-run-walk-get-fit/id1598908362)'s landing page
- [objc.io Swift Talk # 374: Interactive Marquee](https://talk.objc.io/episodes/S01E374-interactive-marquee-view-part-1)

## Utils

### `View.measureHeight` / `measureWidth` 

A simple modifier to measure a view.

Beside being used in the Marquee component, you could use it to make a `.sheet` "fit" its content:
```swift
@State var sheetHeight: CGFloat? = nil

var sheetContent: some View {
    // ...
}

// ...

.sheet(isPresented: $sheetPresented, content: {
    sheetContent
        .measureHeight($sheetHeight)
        .presentationDetents([.height(sheetHeight ?? 0)])
        .presentationDragIndicator(.hidden)
})
```

### `String.unlocalized`

You usually don't need to care too much about localization when prototyping. `.unlocalized` is your safe guard before sending your app to the stores:
- when building in debug configurations, it has no effect.
- when building in Release configurations, it will raise a warning for each call to `.unlocalized`, making it easy for developers to spot where localization work is left to do.


## License

This project is released under the MIT license.
