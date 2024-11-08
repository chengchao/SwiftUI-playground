//
//  MoneyInputField.swift
//  test
//
//  Created by Chao Cheng on 11/8/24.
//

import SwiftUI

struct MoneyInputField: View {
    @Binding var amount: Int
    @State private var numberString = "0"

    var body: some View {
        TextField("", text: $numberString)
            .keyboardType(.decimalPad)
            .padding()
            .onAppear {
                // Set the initial value of numberString based on amount
                numberString = String(format: "%.2f", Double(amount) / 100)
            }
            .onChange(of: numberString) { oldValue, newValue in
                let unformattedValue = newValue.replacingOccurrences(of: ",", with: "")
                numberString = formatNumberString(oldValue: oldValue, newValue: unformattedValue)
                amount = Int((Double(numberString) ?? 0) * 100)
            }
    }

    func formatNumberString(oldValue: String, newValue: String) -> String {
        // Convert to number and format with commas and decimal places
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2 // Set maximum decimal places you want to display

        if newValue == "" {
            return "0"
        }

        var value = newValue

        // truncate at most 2 digits after the dot
        if let dotIndex = newValue.firstIndex(of: ".") {
            let endIndex = newValue.index(dotIndex, offsetBy: 3, limitedBy: newValue.endIndex) ?? newValue.endIndex
            let truncatedString = String(newValue[..<endIndex])
            value = truncatedString
        }

        let isEndWithDot = value.last == "."
        let hasSuffixDotZero = value.hasSuffix(".0")

        if let number = Double(value) {
            let result = formatter.string(from: NSNumber(value: number)) ?? value

            if isEndWithDot {
                return result + "."
            }

            if hasSuffixDotZero {
                return result + ".0"
            }

            return result
        } else {
            return oldValue // Fallback to original if conversion fails
        }
    }
}

#Preview {
    @State var amount: Int = 0
    return MoneyInputField(amount: $amount)
}
