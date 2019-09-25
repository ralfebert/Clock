// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import UIKit

class TimeViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        let mapping = [
            "S": DateFormatter.Style.short,
            "M": .medium,
            "L": .long,
            "XL": .full,
        ]
        let style = mapping[title]!
    }

    func formatter(style: DateFormatter.Style) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = style
        let formattedString = formatter.string(for: Date())
    }

}
