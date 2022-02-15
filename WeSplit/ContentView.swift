//
//  ContentView.swift
//  WeSplit
//
//  Created by Omar Khan  on 09/01/2022.
//

import SwiftUI



struct ContentView: View {
    @State private var useRedText = false
    @State private var checkAmount  = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10,15,20,0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        
        ZStack {
            NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2 ..< 100) {
                                    Text("\($0) people")
                                }
                        }
                    }
                    
                    Section{
                        Picker("Tip Percentages", selection: $tipPercentage){
                            ForEach(tipPercentages, id: \.self){
                                Text($0, format: .percent)
                                    
                                //useRedText.toggle()
                            }
                        }.pickerStyle(.segmented)
                            
                        
                    } header: {
                        Text("How much tip do you want to leave?")
                        
                    }
                    
                    Section {
                        Text(totalPerPerson*Double(numberOfPeople+2), format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor((tipPercentage == 0) ?  .red : .black)
                    } header: {
                        Text("Total Amount")
                    }
                    
                    Section {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    } header: {
                        Text("Amuont per Person")
                    }
                    
                    
                        
                }   .navigationTitle("SwiftUI")
                    .navigationBarTitleDisplayMode(.inline)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            ContentView()
        }
    }
}
