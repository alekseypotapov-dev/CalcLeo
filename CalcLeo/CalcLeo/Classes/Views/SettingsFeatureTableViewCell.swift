import UIKit

final class SettingsFeatureTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        return titleLabel
    }()

    lazy var featureSwitch: UISwitch = {
        let featureSwitch = UISwitch()
        featureSwitch.translatesAutoresizingMaskIntoConstraints = false
        featureSwitch.addTarget(self, action: #selector(switchValueChange(_:)), for: .valueChanged)

        return featureSwitch
    }()

    var switchStateCallback:((Bool) -> (Void))?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(featureSwitch)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            featureSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            featureSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(with designService: DesignServiceProtocol) {
        backgroundColor = designService.viewBackgroundColor
        contentView.backgroundColor = designService.viewBackgroundColor
        titleLabel.backgroundColor = designService.labelBackgroundColor
        titleLabel.textColor = designService.labelTextColor
        featureSwitch.backgroundColor = designService.subviewBackgroundColor
    }

    @objc
    private func switchValueChange(_ sender: UISwitch) {
        switchStateCallback?(sender.isOn)
    }
}
