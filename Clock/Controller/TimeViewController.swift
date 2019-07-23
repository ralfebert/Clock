// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import Combine
import UIKit

func systemTimePublisher() -> AnyPublisher<Date, Never> {
    Timer.publish(every: TimeInterval(1), on: .main, in: .default)
        .autoconnect()
        .eraseToAnyPublisher()
}

class TimeViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!

    var connections = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        systemTimePublisher()
            .map { date in
                DateFormats.timeOnlyFormatter.string(from: date)
            }
            .sink { [weak self] str in
                debugPrint("Updated Text to \(str)")
                self?.timeLabel.text = str
            }
            .store(in: &self.connections)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.connections.forEach { $0.cancel() }
        self.connections.removeAll()
    }

}
