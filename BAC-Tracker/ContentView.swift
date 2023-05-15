import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @ObservedObject private var healthStore = HealthStore()

    var body: some View {
        ZStack {
            VStack {
                Text("BAC Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 50)

                TextField("Enter your BAC", text: $bacInput)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    .keyboardType(.decimalPad)
                    .padding([.leading, .trailing], 20)

                Button(action: {
                    if let bacValue = Double(bacInput) {
                        healthStore.addBACData(bacValue: bacValue)
                        latestBAC = bacValue // update latestBAC here
                        bacInput = ""
                    }
                }) {
                    Text("Submit BAC")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .background(Color.blue).cornerRadius(15)
                        .padding([.leading, .trailing], 20)
                }

                HStack {
                    Text("Latest BAC: ")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.blue)

                    Text("\(latestBAC, specifier: "%.3f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                .padding(.top, 30)
            }
        }
        .onAppear {
            healthStore.getLatestBAC { result in
                latestBAC = result
            }
        }
    }
}

