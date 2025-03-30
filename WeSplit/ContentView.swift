//
//  ContentView.swift
//  WeSplit
//
//  Created by Maria Rachel on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalContribution: Double {
        let numberOfPeopleDouble = Double(numberOfPeople + 2)
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        let totalAmount = checkAmount + tipAmount
        return totalAmount / numberOfPeopleDouble
    }
    
    var totalCheckTipAmount: Double {
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        let totalAmount = checkAmount + tipAmount
        return totalAmount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    } .pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Leaving a tip?")
                }
                
                Section {
                    Text(totalCheckTipAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Amount with Tip")
                }
                
                Section {
                    Text(totalContribution, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Each person will pay")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


}
