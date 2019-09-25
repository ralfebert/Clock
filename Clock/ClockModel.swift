import Combine
import Foundation

class ClockModel: ObservableObject {
    
    @Published var dateStyle : String = "S"
    
    var dateStringPublisher : AnyPublisher<String, Never> {
        // S/M/L -> DateFormatter
        let formatterPublisher = $dateStyle.map(formatterFor(sizeString:))
        
        // DateFormatter + Zeit
        let formatterAndTimePublisher = Publishers.CombineLatest(formatterPublisher, timePublisher())
        
        // DateFormatter + Zeit -> String
        return formatterAndTimePublisher.map { (formatter, date) in
            formatter.string(from: date)
        }.eraseToAnyPublisher()
        
    }
    
}

func timePublisher() -> AnyPublisher<Date, Never> {
    Timer.publish(every: 1, on: .main, in: .default).autoconnect().eraseToAnyPublisher()
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
