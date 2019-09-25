// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import UIKit
import Combine

func timePublisher() -> AnyPublisher<Date, Never> {
    Timer.publish(every: 1, on: .main, in: .default).autoconnect().eraseToAnyPublisher()
}

class TimeViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!

    let formatPublisher = PassthroughSubject<String, Never>()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // S/M/L -> DateFormatter
        let formatterPublisher = formatPublisher.map(formatterFor(sizeString:))
        
        // DateFormatter + Zeit
        let formatterAndTimePublisher = Publishers.CombineLatest(formatterPublisher, timePublisher())
        
        // DateFormatter + Zeit -> String
        let dateStringPublisher = formatterAndTimePublisher.map { (formatter, date) in
            formatter.string(from: date)
        }
        
        // Senke: Aktualisierung des Labels
        dateStringPublisher.sink { [weak self] (string) in
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
        let title = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        formatPublisher.send(title)
    }

}

fileprivate func formatterFor(sizeString: String) -> DateFormatter {
    let mapping = [
        "S": DateFormatter.Style.short,
        "M": .medium,
        "L": .long,
        "XL": .full,
    ]
    let style = mapping[sizeString]!

    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = style
    return formatter
}
