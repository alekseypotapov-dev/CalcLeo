import UIKit

final class MainViewController: UIViewController {

    private let titleLabel = UILabel()
    private let settingsButton = UIButton(type: .detailDisclosure)
    private let calculatorView = CalculatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension MainViewController {

    private func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        calculatorView.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(calculatorView)

        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        NSLayoutConstraint.activate([
            titleLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculatorView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor),
            calculatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        calculatorView.backgroundColor = .red
        view.backgroundColor = .white

        titleLabel.text = "🦁 Calculator"
    }

    @objc
    func openSettings() {
        let settingsViewController = SettingsViewController()
        present(settingsViewController, animated: true, completion: nil)
    }
}
