import UIKit

public protocol ColorSchemeProtocol {

    static var viewBackgroundColor: UIColor { get }
    static var subviewBackgroundColor: UIColor { get }

    static var primaryButtonTextColor: UIColor { get }
    static var primaryButtonBackgroundColor: UIColor { get }

    static var secondaryButtonTextColor: UIColor { get }
    static var secondaryButtonBackgroundColor: UIColor { get }

    static var labelTextColor: UIColor { get }
    static var labelBackgroundColor: UIColor { get }
}

public struct DayColorScheme: ColorSchemeProtocol {

    public static var viewBackgroundColor: UIColor { .white }
    public static var subviewBackgroundColor: UIColor { .white }

    public static var primaryButtonTextColor: UIColor { .black }
    public static var primaryButtonBackgroundColor: UIColor { .orange }

    public static var secondaryButtonTextColor: UIColor { .black }
    public static var secondaryButtonBackgroundColor: UIColor { .gray }

    public static var labelTextColor: UIColor { .black }
    public static var labelBackgroundColor: UIColor { .white }
}

public struct NightColorScheme: ColorSchemeProtocol {

    public static var viewBackgroundColor: UIColor { .black }
    public static var subviewBackgroundColor: UIColor { .black }

    public static var primaryButtonTextColor: UIColor { .white }
    public static var primaryButtonBackgroundColor: UIColor { .orange }

    public static var secondaryButtonTextColor: UIColor { .white }
    public static var secondaryButtonBackgroundColor: UIColor { .gray }

    public static var labelTextColor: UIColor { .white }
    public static var labelBackgroundColor: UIColor { .black }
}
