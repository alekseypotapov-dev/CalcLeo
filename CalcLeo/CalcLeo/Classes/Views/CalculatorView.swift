import UIKit

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
        containerStackView.spacing = 5

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
        mainHorizontalStackView.backgroundColor = .green

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
            mainHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }

    func dataUpdated(models: [[ButtonSymbol]]) {
        var columnStackViews = [UIStackView]()

        for buttonColumn in models {
            var buttonArray = [UIButton]()

            for buttonSymbol in buttonColumn {
                let btn = UIButton(type: .custom)
                btn.setTitle("\(buttonSymbol.labelText)", for: .normal)
                btn.backgroundColor = .cyan
                btn.isHidden = !buttonSymbol.visible
                btn.translatesAutoresizingMaskIntoConstraints = false
                btn.tag = buttonSymbol.id
                btn.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
                buttonArray.append(btn)
            }

            let columnStackView = UIStackView(arrangedSubviews: buttonArray)
            columnStackView.translatesAutoresizingMaskIntoConstraints = false
            columnStackView.axis = .vertical
            columnStackView.alignment = .fill
            columnStackView.distribution = .fillEqually
            columnStackView.spacing = 5

            columnStackViews.append(columnStackView)
        }

        for columnStackView in columnStackViews {
            mainHorizontalStackView.addArrangedSubview(columnStackView)
        }
    }

    func publishError(_ message: String) {

    }

    @objc
    func buttonTap(_ sender: UIButton) {
        print("Button tap id: \(sender.tag)")
    }
}
