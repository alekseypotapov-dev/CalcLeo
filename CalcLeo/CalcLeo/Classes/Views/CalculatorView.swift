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

    func zzz() {
        var button = [UIButton]()

        for i in 0..<20 {
            let btn = UIButton(type: .custom)
            btn.setTitle("\(i)", for: .normal)
            btn.backgroundColor = .cyan
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.tag = i
            button.append(btn)
        }

        let firstColumnVerticalStackView = UIStackView(arrangedSubviews: [button[0], button[1], button[2], button[3]])
        firstColumnVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        firstColumnVerticalStackView.axis = .vertical
        firstColumnVerticalStackView.alignment = .fill
        firstColumnVerticalStackView.distribution = .fillEqually
        firstColumnVerticalStackView.spacing = 5

        let secondColumnVerticalStackView = UIStackView(arrangedSubviews: [button[4], button[5], button[6], button[7]])
        secondColumnVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        secondColumnVerticalStackView.axis = .vertical
        secondColumnVerticalStackView.alignment = .fill
        secondColumnVerticalStackView.distribution = .fillEqually
        secondColumnVerticalStackView.spacing = 5

        let thirdColumnVerticalStackView = UIStackView(arrangedSubviews: [button[8], button[9], button[10], button[11]])
        thirdColumnVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        thirdColumnVerticalStackView.axis = .vertical
        thirdColumnVerticalStackView.alignment = .fill
        thirdColumnVerticalStackView.distribution = .fillEqually
        thirdColumnVerticalStackView.spacing = 5

        let fourthColumnVerticalStackView = UIStackView(arrangedSubviews: [button[12], button[13], button[14], button[15]])
        fourthColumnVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        fourthColumnVerticalStackView.axis = .vertical
        fourthColumnVerticalStackView.alignment = .fill
        fourthColumnVerticalStackView.distribution = .fillEqually
        fourthColumnVerticalStackView.spacing = 5

        let fifthColumnVerticalStackView = UIStackView(arrangedSubviews: [button[16], button[17], button[18], button[19]])
        fifthColumnVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        fifthColumnVerticalStackView.axis = .vertical
        fifthColumnVerticalStackView.alignment = .fill
        fifthColumnVerticalStackView.distribution = .fillEqually
        fifthColumnVerticalStackView.spacing = 5

        mainHorizontalStackView.addArrangedSubview(firstColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(secondColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(thirdColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(fourthColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(fifthColumnVerticalStackView)
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
