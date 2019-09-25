// (C) 2019, Ralf Ebert - iOS Example Project: Clock
// License: https://opensource.org/licenses/0BSD

import UIKit
import SwiftUI

@UIApplicationMain
class ClockApp: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow()
        window.rootViewController = UIHostingController(rootView: ClockView())
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}
