//  ContentView.swift
//  BAC-Tracker
//
//  Created by Anthony Sky Ng-Thow-Hing on 5/15/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @ObservedObject private var healthStore = HealthStore()

    var body: some View {
        VStack {
            TextField("Enter your BAC", text: $bacInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            Button("Submit BAC") {
                if let bacValue = Double(bacInput) {
                    healthStore.addBACData(bacValue: bacValue)
                    latestBAC = bacValue // update latestBAC here
                    bacInput = ""
                }
            }
            .padding()

            Text("Latest BAC: \(latestBAC, specifier: "%.3f")")
                .padding()
        }
        .onAppear {
            healthStore.getLatestBAC { result in
                latestBAC = result
            }
        }
    }
}
