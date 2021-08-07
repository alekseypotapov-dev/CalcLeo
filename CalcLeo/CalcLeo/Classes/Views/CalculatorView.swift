import UIKit

final class CalculatorView: UIView {

    var designService: DesignServiceProtocol!

    private lazy var mainHorizontalStackView: UIStackView = {
        let containerStackView = UIStackView()
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        return containerStackView
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = designService.labelBackgroundColor
        label.font = UIFont.systemFont(ofSize: 60)
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    
    func setupUI(with designService: DesignServiceProtocol) {
        self.designService = designService

        setupLayout()
        setupStackView()
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

    private func setupStackView() {

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

        mainHorizontalStackView.axis = .horizontal
        mainHorizontalStackView.alignment = .fill
        mainHorizontalStackView.distribution = .fillEqually
        mainHorizontalStackView.spacing = 5

        mainHorizontalStackView.addArrangedSubview(firstColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(secondColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(thirdColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(fourthColumnVerticalStackView)
        mainHorizontalStackView.addArrangedSubview(fifthColumnVerticalStackView)
    }
}
