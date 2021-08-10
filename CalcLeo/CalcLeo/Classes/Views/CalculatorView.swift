import UIKit
import MathLeo

final class CalculatorView: UIView {

    var designService: DesignServiceProtocol

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
        label.font = UIFont.systemFont(ofSize: 60)
        label.text = "0"
        label.textAlignment = .right

        return label
    }()

    init(designService: DesignServiceProtocol) {
        self.designService = designService
        super.init(frame: .zero)
        self.setupLayout()
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView() {
        viewModel.prepareObjects()
        setupUI()
    }

    private func setupLayout() {
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

    private func setupUI() {
        resultLabel.backgroundColor = designService.labelBackgroundColor
        resultLabel.textColor = designService.labelTextColor
        backgroundColor = designService.viewBackgroundColor
        mainHorizontalStackView.backgroundColor = designService.subviewBackgroundColor
    }

    @objc
    func buttonTap(_ sender: UIButton) {
        viewModel.buttonTap(with: sender.tag)
    }
}

extension CalculatorView: CalculatorViewModelDelegate {

    func dataUpdated(models: [[Feature]]) {

        DispatchQueue.main.async {
            self.mainHorizontalStackView.removeAllArrangedSubviews()
            var columnStackViews = [UIStackView]()

            for buttonColumn in models {
                var buttonArray = [UIButton]()

                for buttonFeature in buttonColumn {
                    let btn = UIButton(type: .system)
                    btn.setTitle("\(buttonFeature.labelText)", for: .normal)
                    switch buttonFeature.type {
                    case .digit, .comma, .equals:
                        btn.backgroundColor = self.designService.secondaryButtonBackgroundColor
                        btn.setTitleColor(self.designService.secondaryButtonTextColor, for: .normal)
                    default:
                        btn.backgroundColor = self.designService.primaryButtonBackgroundColor
                        btn.setTitleColor(self.designService.primaryButtonTextColor, for: .normal)
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
                columnStackView.backgroundColor = self.designService.subviewBackgroundColor
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

    func updateResult(with text: String) {
        DispatchQueue.main.async {
            self.resultLabel.text = text
        }
    }

    func publishError(_ message: String) {
        // tod: show alert with error
    }
}
