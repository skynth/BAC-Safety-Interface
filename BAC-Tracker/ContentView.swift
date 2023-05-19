import SwiftUI
import HealthKit
import CareKit
import CareKitUI
import CareKitStore

struct ContentView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @ObservedObject private var healthStore = HealthStore()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Text("Sip wisely, stay lively")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Dark"))
                    .padding(.bottom, 50)

                TextField("Enter your BAC", text: $bacInput)
                    .padding()
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
                        .background(Color("Main")).cornerRadius(15)
                        .padding([.leading, .trailing], 20)
                }

                HStack {
                    Text("Latest BAC: ")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color("Dark"))

                    Text("\(latestBAC, specifier: "%.3f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark"))
                }
                .padding(.top, 30)
                
                ChartView()
                    .frame(height: 200)
                    .padding([.leading, .trailing], 20)

            }
        }
        .onAppear {
            healthStore.getLatestBAC { result in
                latestBAC = result
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ChartView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> OCKCartesianChartView {
        let chartView = OCKCartesianChartView(type: .bar)
        chartView.headerView.titleLabel.text = "BAC Level"
        var dataSeries = OCKDataSeries(values: [0, 1, 1, 2, 3, 3, 2], title: "BAC") //Need to replace with call to HealthStore
        dataSeries.gradientEndColor = UIColor(Color("Main"))
        dataSeries.gradientStartColor = UIColor(Color("Main"))
        chartView.graphView.dataSeries = [dataSeries]
        return chartView
    }

    func updateUIView(_ uiView: OCKCartesianChartView, context: Context) {
        // Here you could update your view with new data
    }
}



