import UIKit
import DesignLeo

enum ColorSettingType {
    case day, night
}

protocol DesignServiceProtocol {

    var colorSetting: ColorSettingType { get set }

    var primaryButtonBackgroundColor: UIColor { get }
    var secondaryButtonBackgroundColor: UIColor { get }
    var secondaryButtonTextColor: UIColor { get }
    var primaryButtonTextColor: UIColor { get }
    var labelTextBackgroundColor: UIColor { get }
    var labelBackgroundColor: UIColor { get }

    var primaryTextLabelHeight: CGFloat { get }
    var primaryButtonHeight: CGFloat { get }
    var primaryButtonWidth: CGFloat { get }
}

struct DesignService: DesignServiceProtocol {

    // MARK: Colors
    var colorSetting: ColorSettingType = .day

    var primaryButtonBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.primaryButtonBackgroundColor
        case .night: return NightColorScheme.primaryButtonBackgroundColor
        }
    }

    var labelTextBackgroundColor: UIColor {
        switch colorSetting {
        case .day: return DayColorScheme.labelTextBackgroundColor
        case .night: return NightColorScheme.labelTextBackgroundColor
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
}
