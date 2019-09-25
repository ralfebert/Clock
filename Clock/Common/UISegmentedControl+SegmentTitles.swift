// Created by Omar Albeik on 9/28/16.
// Copyright © 2016 SwifterSwift
// MIT license
// https://github.com/SwifterSwift/SwifterSwift/

import UIKit

public extension UISegmentedControl {

    /// SwifterSwift: Segments titles.
    var segmentTitles: [String] {
        get {
            let range = 0 ..< self.numberOfSegments
            return range.compactMap { titleForSegment(at: $0) }
        }
        set {
            self.removeAllSegments()
            for (index, title) in newValue.enumerated() {
                self.insertSegment(withTitle: title, at: index, animated: false)
            }
        }
    }

}
