import UIKit

final class MainViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let calculatorView: CalculatorView = {
        let calculator = CalculatorView()
        calculator.translatesAutoresizingMaskIntoConstraints = false
        return calculator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension MainViewController {

    private func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(calculatorView)

        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calculatorView.topAnchor.constraint(equalTo: settingsButton.bottomAnchor),
            calculatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calculatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        calculatorView.backgroundColor = .red
        view.backgroundColor = .white

        titleLabel.text = "🦁 Calculator"

        calculatorView.setupUI(with: DesignService())
    }

    @objc
    func openSettings() {
        let settingsViewController = SettingsViewController()
        present(settingsViewController, animated: true, completion: nil)
    }
}
