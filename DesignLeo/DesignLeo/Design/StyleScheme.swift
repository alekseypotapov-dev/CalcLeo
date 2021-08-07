import UIKit

public protocol StyleSchemeProtocol {

    static var primaryTextFont: UIFont { get }
    static var secondaryTextFont: UIFont { get }

    static var primaryButtonTextFont: UIFont { get }
    static var secondaryButtonTextFont: UIFont { get }

    static var primaryTextLabelHeight: CGFloat { get }
    static var primaryTextSize: CGFloat { get }
    static var secondaryTextSize: CGFloat { get }

    static var primaryButtonHeight: CGFloat { get }
    static var primaryButtonWidth: CGFloat { get }
    static var primaryButtonTextSize: CGFloat { get }

    static var secondaryButtonHeight: CGFloat { get }
    static var secondaryButtonWidth: CGFloat { get }
    static var secondaryButtonTextSize: CGFloat { get }
}

public struct Style: StyleSchemeProtocol {

    public static var primaryTextFont: UIFont { UIFont.systemFont(ofSize: primaryTextSize, weight: .bold) }
    public static var secondaryTextFont: UIFont { UIFont.systemFont(ofSize: secondaryTextSize, weight: .light) }

    public static var primaryButtonTextFont: UIFont { UIFont.systemFont(ofSize: primaryButtonTextSize, weight: .medium) }
    public static var secondaryButtonTextFont: UIFont { UIFont.systemFont(ofSize: secondaryButtonTextSize, weight: .light) }

    public static var primaryTextLabelHeight: CGFloat { 200.0 }
    public static var primaryTextSize: CGFloat { 20.0 }
    public static var secondaryTextSize: CGFloat { 18.0 }

    public static var primaryButtonHeight: CGFloat { 40 }
    public static var primaryButtonWidth: CGFloat { 40 }
    public static var primaryButtonTextSize: CGFloat { 20 }

    public static var secondaryButtonHeight: CGFloat { 40 }
    public static var secondaryButtonWidth: CGFloat { 40 }
    public static var secondaryButtonTextSize: CGFloat { 18 }
}
