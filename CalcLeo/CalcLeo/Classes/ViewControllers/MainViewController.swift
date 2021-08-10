import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func applySettings()
}

final class MainViewController: UIViewController {

    private lazy var designService: DesignService = {
        return DesignService()
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🦁 Calculator"
        
        return label
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        return button
    }()

    private lazy var calculatorView: CalculatorView = {
        let calculator = CalculatorView(designService: designService)
        calculator.translatesAutoresizingMaskIntoConstraints = false
        calculator.updateView()

        return calculator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupUI()
    }
}

extension MainViewController {

    private func setupLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(settingsButton)
        view.addSubview(calculatorView)

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
    }

    private func setupUI() {
        view.backgroundColor = designService.viewBackgroundColor
        titleLabel.backgroundColor = designService.subviewBackgroundColor
        titleLabel.textColor = designService.labelTextColor
    }

    @objc
    func openSettings() {
        let settingsViewController = SettingsViewController(designService: designService)
        settingsViewController.delegate = self
        present(settingsViewController, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewControllerDelegate {

    func applySettings() {
        setupUI()
        calculatorView.updateView()
    }
}
