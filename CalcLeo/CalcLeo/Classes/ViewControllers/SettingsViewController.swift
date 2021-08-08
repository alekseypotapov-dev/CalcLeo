import UIKit

final class SettingsViewController: UIViewController {

    private var toolbarView: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(closeView))
        toolBar.setItems([flexibleSpaceItem, doneBarButtonItem], animated: false)

        return toolBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension SettingsViewController {

    private func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        view.addSubview(toolbarView)

        NSLayoutConstraint.activate([
            toolbarView.topAnchor.constraint(equalTo: view.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func closeView() {
        dismiss(animated: true, completion: nil)
    }
}
