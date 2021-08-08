import UIKit
import MathLeo

final class CalculatorView: UIView, CalculatorViewModelDelegate {

    var designService: DesignServiceProtocol?

    private lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel(delegate: self)
    }()

    private lazy var mainHorizontalStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillEqually
        containerStackView.spacing = 2

        return containerStackView
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = designService?.labelBackgroundColor
        label.font = UIFont.systemFont(ofSize: 60)
        label.text = "0"
        label.textAlignment = .right

        return label
    }()

    func setupUI(with designService: DesignServiceProtocol) {
        self.designService = designService

        setupLayout()
        viewModel.prepareObjects()
    }

    private func setupLayout() {
        mainHorizontalStackView.backgroundColor = .white

        addSubview(resultLabel)
        addSubview(mainHorizontalStackView)

        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            resultLabel.topAnchor.constraint(equalTo: topAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 120),
            mainHorizontalStackView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor),
            mainHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

    func dataUpdated(models: [[Feature]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            for arrangedSubview in self.mainHorizontalStackView.arrangedSubviews {
                self.mainHorizontalStackView.removeArrangedSubview(arrangedSubview)
            }

            var columnStackViews = [UIStackView]()

            for buttonColumn in models {
                var buttonArray = [UIButton]()

                for buttonFeature in buttonColumn {
                    let btn = UIButton(type: .system)
                    btn.setTitle("\(buttonFeature.labelText)", for: .normal)
                    switch buttonFeature.type {
                    case .digit, .comma, .equals:
                        btn.backgroundColor = self.designService?.secondaryButtonBackgroundColor
                        btn.setTitleColor(self.designService?.secondaryButtonTextColor, for: .normal)
                    default:
                        btn.backgroundColor = self.designService?.primaryButtonBackgroundColor
                        btn.setTitleColor(self.designService?.primaryButtonTextColor, for: .normal)
                    }
                    btn.isHidden = !buttonFeature.visible
                    btn.translatesAutoresizingMaskIntoConstraints = false
                    btn.tag = buttonFeature.id
                    btn.layer.cornerRadius = 8
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                    btn.addTarget(self, action: #selector(self.buttonTap(_:)), for: .touchUpInside)

                    buttonArray.append(btn)
                }

                let columnStackView = UIStackView(arrangedSubviews: buttonArray)
                columnStackView.translatesAutoresizingMaskIntoConstraints = false
                columnStackView.axis = .vertical
                columnStackView.alignment = .fill
                columnStackView.distribution = .fillEqually
                columnStackView.spacing = 2

                columnStackViews.append(columnStackView)
            }

            for columnStackView in columnStackViews {
                self.mainHorizontalStackView.addArrangedSubview(columnStackView)
            }
        }
    }

    func publishError(_ message: String) {
        // tod: show alert with error
    }

    func updateResult(with text: String) {
        resultLabel.text = text
    }

    @objc
    func buttonTap(_ sender: UIButton) {
        viewModel.buttonTap(with: sender.tag)
    }
}
