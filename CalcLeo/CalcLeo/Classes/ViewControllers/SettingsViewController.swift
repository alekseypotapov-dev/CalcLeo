import UIKit

final class SettingsViewController: UIViewController {

    private var toolbarView = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension SettingsViewController {

    private func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(toolbarView)

        NSLayoutConstraint.activate([
            toolbarView.topAnchor.constraint(equalTo: view.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(closeView))
        toolbarView.setItems([flexibleSpaceItem, doneBarButtonItem], animated: true)

        view.backgroundColor = .blue
    }

    @objc private func closeView() {
        dismiss(animated: true, completion: nil)
    }
}
