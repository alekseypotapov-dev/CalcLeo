import UIKit
import MathLeo

final class SettingsViewController: UIViewController, SettingsViewModelDelegate {

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
            return cell
        }
        return dataSource
    }()

    private lazy var viewModel: SettingsViewModel = {
        return SettingsViewModel(delegate: self)
    }()

    private var toolbarView: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(closeView))
        toolBar.setItems([flexibleSpaceItem, doneBarButtonItem], animated: false)

        return toolBar
    }()

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
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            toolbarView.topAnchor.constraint(equalTo: view.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func closeView() {
        dismiss(animated: true, completion: nil)
    }
}
