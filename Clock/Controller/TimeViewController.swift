// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import Combine
import UIKit

func systemTimePublisher() -> AnyPublisher<Date, Never> {
    #warning("1. Funktion so implementieren, das ein Timer-Publisher erstellt wird mittels Timer.publish, autoconnect verwenden um diesen automatisch zu verbinden und mit eraseToAnyPublisher die Typsignatur zu AnyPublisher bereinigen.")
    fatalError()
}

class TimeViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        #warning("2. Datumswert des `systemTimePublisher` mit `map` formatieren und mit `sink` dem Label zuweisen")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        #warning("3. Aufräumarbeiten: cancel implementieren")
    }

}
