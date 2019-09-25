// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import UIKit
import Combine

class TimeViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!

    var model = ClockModel()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Senke: Aktualisierung des Labels
        model.dateStringPublisher.sink { [weak self] (string) in
            self?.timeLabel.text = string
        }.store(in: &self.cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // TODO: prüfen ob es einfacher zu subscriben geht -> z.B. let pub = NotificationCenter.default.publisher(for: NSNotification.Name.valueChanged, object: segmentedControl)
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        model.dateStyle = title
    }

}
