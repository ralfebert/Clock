// MIT License
//
// Copyright (c) 2019 Ralf Ebert
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Combine
import Foundation

class ClockModel: ObservableObject {

    @Published var dateStyle = SizeOption.S
    @Published var formattedTime = ""

    private var subscriptions = Set<AnyCancellable>()

    init() {
        timePublisher()
            .combineLatest($dateStyle.map { $0.formatter })
            .map { date, formatter in formatter.string(from: date) }
            .assign(to: \.formattedTime, on: self)
            .store(in: &self.subscriptions)
    }

}

func timePublisher() -> AnyPublisher<Date, Never> {
    Timer.publish(every: 1, on: .main, in: .default).autoconnect().eraseToAnyPublisher()
}

enum SizeOption: String, CustomStringConvertible, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case S, M, L, XL

    var description: String {
        return self.rawValue
    }

    var formatterStyle: DateFormatter.Style {
        switch self {
            case .S: return .short
            case .M: return .medium
            case .L: return .long
            case .XL: return .full
        }
    }

    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = self.formatterStyle
        return formatter
    }

}
