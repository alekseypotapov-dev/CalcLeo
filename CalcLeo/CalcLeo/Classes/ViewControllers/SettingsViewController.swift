import UIKit
import MathLeo

final class SettingsViewController: UIViewController, SettingsViewModelDelegate {

    weak var delegate: MainViewControllerDelegate?
    private let designService: DesignServiceProtocol

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsFeatureTableViewCell.self, forCellReuseIdentifier: String(describing: SettingsFeatureTableViewCell.self))
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = 40.0
        
        return tableView
    }()

    private lazy var tableViewDataSource: UITableViewDiffableDataSource<Int, Feature> = {
        let dataSource = UITableViewDiffableDataSource<Int, Feature>(tableView: tableView) { tableView, indexPath, feature -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsFeatureTableViewCell.self), for: indexPath) as? SettingsFeatureTableViewCell else {
                return UITableViewCell()
            }
            cell.titleLabel.text = feature.labelText
            cell.featureSwitch.isOn = feature.visible
            cell.switchStateCallback = { isOn in
                self.viewModel.updateFeature(with: feature.id, visible: isOn)
            }
            return cell
        }
        return dataSource
    }()

    private lazy var viewModel: SettingsViewModel = {
        return SettingsViewModel(delegate: self)
    }()

    private lazy var toolbarView: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: nil, action: #selector(closeView))
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: nil, action: #selector(saveAndCloseView))
        toolBar.setItems([closeBarButtonItem, flexibleSpaceItem, saveBarButtonItem], animated: false)

        return toolBar
    }()

    private lazy var currentColorSchemeSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.isOn = designService.colorSetting == .day
        switcher.addTarget(self, action: #selector(swichColorScheme(_:)), for: .valueChanged)

        return switcher
    }()

    private lazy var currentColorSchemeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Colorsheme: \(designService.colorSetting.rawValue)"

        return label
    }()

    init(designService: DesignServiceProtocol) {
        self.designService = designService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.prepareObjects()
    }

    func dataUpdated(models: [Feature]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Feature>()
        snapshot.appendSections([1])
        snapshot.appendItems(models, toSection: 1)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }

    func publishError(_ message: String) {

    }
}

extension SettingsViewController {

    private func setupUI() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        view.addSubview(toolbarView)
        view.addSubview(currentColorSchemeLabel)
        view.addSubview(currentColorSchemeSwitch)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            toolbarView.topAnchor.constraint(equalTo: view.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentColorSchemeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentColorSchemeLabel.topAnchor.constraint(equalTo: toolbarView.bottomAnchor),
            currentColorSchemeLabel.heightAnchor.constraint(equalToConstant: 50),
            currentColorSchemeSwitch.centerYAnchor.constraint(equalTo: currentColorSchemeLabel.centerYAnchor),
            currentColorSchemeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: currentColorSchemeLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc
    private func saveAndCloseView() {
        viewModel.updateFeaturesList()
        dismiss(animated: true) {
            self.delegate?.applySettings()
        }
    }

    @objc
    private func closeView() {
        dismiss(animated: true, completion: nil)
    }

    @objc
    private func swichColorScheme(_ sender: UISwitch) {
        if sender.isOn {
            designService.switchColorSchemeTo(newColorScheme: .day)
        } else {
            designService.switchColorSchemeTo(newColorScheme: .night)
        }

        currentColorSchemeLabel.text = "Current Colorsheme: \(designService.colorSetting.rawValue)"
    }
}
