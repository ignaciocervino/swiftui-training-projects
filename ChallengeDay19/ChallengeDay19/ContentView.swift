//
//  ContentView.swift
//  ChallengeDay19
//
//  Created by Ignacio Cervino on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var value: Double = 0.0
    @State private var lengthUnits = Unit.allCases
    @State private var fromUnit = Unit.meters
    @State private var toUnit = Unit.meters
    @State private var result = 0.0
    @FocusState private var amountIsFocus: Bool

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Amount", value: $value, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocus)
                        Picker("Unit", selection: $fromUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                    } header: {
                        Text("Enter your height")
                    }

                    Section {
                        Picker("Unit", selection: $toUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                    } header: {
                        Text("Contert to")
                    }
                }
                .navigationTitle("Height Converter")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocus = false
                        }
                    }
                }

                Spacer()

                Section {
                    HStack {
                        Text("Result:")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(result, format: .number)
                            .font(.headline)
                            .foregroundColor(.black) // Custom text color
                    }
                    .padding(.bottom, 20)

                }
                .padding(.vertical, 20) // Add vertical padding

                Spacer()

                Button("Convert") {
                    value = fromUnit.convertToMeter(value: value)
                    result = convertTo(meterValue: value, unit: toUnit)
                }
                .foregroundColor(.white) // Custom button text color
                .padding(.vertical, 10) // Add vertical padding
                .padding(.horizontal, 20) // Add horizontal padding
                .background(Color.blue) // Set button background color
                .cornerRadius(8) // Rounded corners
                .padding(.bottom, 20) // Add bottom padding
            }
            .padding() // Add padding around the VStack
            .background(Color(UIColor.systemGroupedBackground))
        }
        .colorScheme(.light)
    }
}

func convertTo(meterValue: Double, unit: Unit) -> Double {
    switch unit {
    case .feet:
        return meterValue * 3.281
    case .meters:
        return meterValue
    case .kilometers:
        return meterValue / 1000
    case .yards:
        return meterValue * 1.094
    case .miles:
        return meterValue / 1609
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
