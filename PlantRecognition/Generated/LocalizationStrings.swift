// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum MainTabBar {
    public enum Tabs {
      /// My plants
      public static let myPlants = L10n.tr("Localizable", "MainTabBar.Tabs.myPlants")
      /// Search
      public static let search = L10n.tr("Localizable", "MainTabBar.Tabs.search")
      /// Settings
      public static let settings = L10n.tr("Localizable", "MainTabBar.Tabs.settings")
    }
  }

  public enum MyPlantsTab {
    /// My plants
    public static let title = L10n.tr("Localizable", "MyPlantsTab.title")
    public enum NoPlantsYet {
      /// Add your first plant
      public static let addYourFirstPlantButton = L10n.tr("Localizable", "MyPlantsTab.NoPlantsYet.AddYourFirstPlantButton")
      public enum QuestionCard {
        public enum Title {
          /// What will be your first plant?
          public static let part1 = L10n.tr("Localizable", "MyPlantsTab.NoPlantsYet.QuestionCard.Title.part1")
          /// Search it now
          public static let part2 = L10n.tr("Localizable", "MyPlantsTab.NoPlantsYet.QuestionCard.Title.part2")
        }
      }
    }
  }

  public enum SearchTab {
    /// Plants search
    public static let title = L10n.tr("Localizable", "SearchTab.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
