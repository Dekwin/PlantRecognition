// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Colors {
    public static let additionalGreen = ColorAsset(name: "AdditionalGreen")
    public enum BgGradient {
      public static let bgGradient1 = ColorAsset(name: "BgGradient1")
      public static let bgGradient2 = ColorAsset(name: "BgGradient2")
      public static let bgGradient3 = ColorAsset(name: "BgGradient3")
    }
    public static let black = ColorAsset(name: "Black")
    public static let greenLight = ColorAsset(name: "GreenLight")
    public static let grey = ColorAsset(name: "Grey")
    public static let greyLight = ColorAsset(name: "GreyLight")
    public static let mainGreen = ColorAsset(name: "MainGreen")
    public static let orange = ColorAsset(name: "Orange")
    public static let red = ColorAsset(name: "Red")
    public static let white = ColorAsset(name: "White")
  }
  public enum Images {
    public enum Components {
      public enum Buttons {
        public static let addPlant = ImageAsset(name: "AddPlant")
      }
      public enum Cards {
        public static let cardBg = ImageAsset(name: "CardBg")
      }
    }
    public enum DemoImages {
      public static let demoPlant = ImageAsset(name: "DemoPlant")
    }
    public enum Iconly {
      public static let greenDroplet = ImageAsset(name: "GreenDroplet")
      public static let greenFertilizer = ImageAsset(name: "GreenFertilizer")
      public static let greenPots = ImageAsset(name: "GreenPots")
      public static let more = ImageAsset(name: "More")
      public static let notSelectedLeaf = ImageAsset(name: "NotSelectedLeaf")
      public static let notSelectedSearch = ImageAsset(name: "NotSelectedSearch")
      public static let notSelectedSetting = ImageAsset(name: "NotSelectedSetting")
      public static let selectedLeaf = ImageAsset(name: "SelectedLeaf")
      public static let selectedSearch = ImageAsset(name: "SelectedSearch")
      public static let selectedSetting = ImageAsset(name: "SelectedSetting")
    }
    public enum TabBar {
      public static let tabBarBg = ImageAsset(name: "TabBarBg")
    }
    public enum Tabs {
      public enum MyPlants {
        public static let question = ImageAsset(name: "Question")
      }
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
