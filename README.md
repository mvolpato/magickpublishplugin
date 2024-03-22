# ImageMagick plugin for Publish

A [Publish](https://github.com/johnsundell/publish) plugin that helps running [ImageMagick](https://imagemagick.org) 
commands while building any Publish website.

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/mvolpato/magickpublishplugin", from: "0.3.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "MagickPublishPlugin"
            ]
        )
    ]
    ...
)
```

Then import MagickPublishPlugin wherever you’d like to use it:

```swift
import MagickPublishPlugin
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Usage

You need ImageMagick version 6 to use the `optimizeForWeb(imagesInFolder: String)` method.

You can use other methods with version 7.

The plugin can then be used within any publishing pipeline like this:

```swift
import MagickPublishPlugin
...
try DeliciousRecipes().publish(using: [
...
.installPlugin(.optimizeForWeb(imagesInFolder: "Output/assets/images/blog/"))
...
])
```

which will use a quite good [image transformation by Dave Newton](https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/). 

If you want more control over the transformation you can use, for instance,

```swift
import MagickPublishPlugin
...
try DeliciousRecipes().publish(using: [
.installPlugin(
...
    .magick(arguments: [
                "mogrify",
                "-thumbnail",
                "400",
            ], 
            imagesFolder: "Output/assets/images/blog/")
)
...
])
```

You can also run the command on a single file:

```swift
import MagickPublishPlugin
...
try DeliciousRecipes().publish(using: [
.installPlugin(
...
    .magick(arguments: [
                "mogrify",
                "-thumbnail",
                "400",
                ], 
                imageFile: "Output/assets/images/blog/my-cat-eating-a-burrito.jpg")
)
...
])
```

You probably want to run this step after `.copyResources()`.
