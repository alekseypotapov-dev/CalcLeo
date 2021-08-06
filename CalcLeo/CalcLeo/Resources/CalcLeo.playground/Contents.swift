import UIKit
import PlaygroundSupport

class PlaygroundVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let numberPadView = NumberPadView()
        view.addSubview(numberPadView)

        view.translatesAutoresizingMaskIntoConstraints = false
        numberPadView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            numberPadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            numberPadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            numberPadView.topAnchor.constraint(equalTo: view.topAnchor),
            numberPadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

PlaygroundPage.current.liveView = PlaygroundVC()
