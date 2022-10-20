
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    private var total : Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let totalAmount = checkAmount + tipValue
        
        return totalAmount
    }
    private var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let totalAmount = checkAmount + tipValue
        let totalPerPerson = totalAmount / peopleCount
        return totalPerPerson
    }
    private var tipPercenteges = [10,15,20,25,0]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2..<100 , id: \.self) { item in
                            Text("\(item) People")
                        }
                    }
                }
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercenteges , id: \.self) {
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you leave?")
                }
                Section {
                    Text("\(total,format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                } header: {
                     Text("Amount")
                }
                Section {
                    Text("\(totalPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                } header: {
                     Text("Amount Per Person")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
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
