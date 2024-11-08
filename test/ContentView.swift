//
//  ContentView.swift
//  test
//
//  Created by Chao Cheng on 11/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var amount = 0

    var body: some View {
        MoneyInputField(amount: $amount)
    }
}

#Preview {
    ContentView()
}
