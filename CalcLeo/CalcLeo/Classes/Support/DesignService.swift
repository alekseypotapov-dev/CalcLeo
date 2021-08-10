import UIKit
import DesignLeo

enum ColorSetting: String {
    case day, night
}

protocol DesignServiceProtocol {

    var colorSetting: ColorSetting { get }

    var viewBackgroundColor: UIColor { get }
    var subviewBackgroundColor: UIColor { get }

    var primaryButtonBackgroundColor: UIColor { get }
    var secondaryButtonBackgroundColor: UIColor { get }
    var secondaryButtonTextColor: UIColor { get }
    var primaryButtonTextColor: UIColor { get }
    var labelTextColor: UIColor { get }
    var labelBackgroundColor: UIColor { get }

    var primaryTextLabelHeight: CGFloat { get }
    var primaryButtonHeight: CGFloat { get }
    var primaryButtonWidth: CGFloat { get }

    func switchColorSchemeTo(newColorScheme: ColorSetting)
}

class DesignService: DesignServiceProtocol {

    // MARK: Colors
    private let kColorScheme = "ColorSchemeConstant"
    var colorSetting: ColorSetting {
        get {
            if let value = UserDefaults.standard.string(forKey: kColorScheme) {
                return ColorSetting(rawValue: value) ?? .day
            } else {
                return .day
            }
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: kColorScheme)
        }
    }

    var viewBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.viewBackgroundColor
        case .night: return NightColorScheme.viewBackgroundColor
        }
    }

    var subviewBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.subviewBackgroundColor
        case .night: return NightColorScheme.subviewBackgroundColor
        }
    }

    var primaryButtonBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.primaryButtonBackgroundColor
        case .night: return NightColorScheme.primaryButtonBackgroundColor
        }
    }

    var labelTextColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.labelTextColor
        case .night: return NightColorScheme.labelTextColor
        }
    }

    var labelBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.labelBackgroundColor
        case .night: return NightColorScheme.labelBackgroundColor
        }
    }

    var primaryButtonTextColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.primaryButtonTextColor
        case .night: return NightColorScheme.primaryButtonTextColor
        }
    }

    var secondaryButtonBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.secondaryButtonBackgroundColor
        case .night: return NightColorScheme.secondaryButtonBackgroundColor
        }
    }

    var secondaryButtonTextColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.secondaryButtonTextColor
        case .night: return NightColorScheme.secondaryButtonTextColor
        }
    }

    // MARK: Styles
    var primaryTextLabelHeight: CGFloat { Style.primaryTextLabelHeight }
    var primaryButtonHeight: CGFloat { Style.primaryButtonHeight }
    var primaryButtonWidth: CGFloat { Style.primaryButtonWidth }

    func switchColorSchemeTo(newColorScheme: ColorSetting) {
        colorSetting = newColorScheme
    }
}
