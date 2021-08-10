import UIKit

class AlertService {

    static func showErrorAlert(with error: Error) {
        let alert = UIAlertController(title: "Error", message: (error as CustomStringConvertible).description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
