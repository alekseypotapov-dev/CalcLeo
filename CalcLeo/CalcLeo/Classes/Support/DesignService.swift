import UIKit
import DesignLeo

enum ColorSettingType {
    case day, night
}

protocol DesignServiceProtocol {
    var colorSetting: ColorSettingType { get set }

    var primaryButtonBackgroundColor: UIColor { get }
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

    // MARK: Styles
    var primaryTextLabelHeight: CGFloat { Style.primaryTextLabelHeight }
    var primaryButtonHeight: CGFloat { Style.primaryButtonHeight }
    var primaryButtonWidth: CGFloat { Style.primaryButtonWidth }
}
