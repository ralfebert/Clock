//
//  ClockView.swift
//  Clock
//
//  Created by Ralf Ebert on 25.09.19.
//

import SwiftUI

struct ClockView: View {
    
    @ObservedObject var model = ClockModel()
    
    let styles = ["S", "M", "L", "XL"]
    
    @State var pickerSelection : Int = 0
    @State var currentFormattedDate : String = ""
    
    var body: some View {
 
        if model.dateStyle != styles[pickerSelection] {
            model.dateStyle = styles[pickerSelection]
        }
        
        return VStack {
            Picker(selection: $pickerSelection, label: Text("Date Format")) {
                ForEach(0..<styles.count) { idx in
                    Text(self.styles[idx])
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Text("\(pickerSelection)")
            
            Text(currentFormattedDate)
                
        }
        .onReceive(model.dateStringPublisher) { (string) in
                self.currentFormattedDate = string
        }
    
        
        
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
