import SwiftUI
import HealthKit
import CareKit
import CareKitUI
import CareKitStore

struct HomeView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @State private var allBACData: [Double] = []
    @ObservedObject private var healthStore = HealthStore()
    
    
    var body: some View {
        NavigationView{
        ZStack {
            Image("background")
                  .resizable()
                  .scaledToFill()
                  .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Sip wisely, stay lively")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Dark"))
                    .padding(.bottom, 30)
                    .padding(.top, 100)
                
                NavigationLink(
                    destination: SessionView(),
                    label: {
                        Text("Start a Session")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .background(Color("Main")).cornerRadius(15)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 100)

                    })
                
                HStack{
                    Text("Drink History")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark"))
                        .padding([.leading, .trailing], 30)
                    Spacer()
                }
                
                ChartView(data: allBACData)
                    .frame(height: 200)
                    .padding([.leading, .trailing], 30)
                Spacer()
            }
        }}
        .onAppear {
            healthStore.getLatestBAC { result in
                latestBAC = result
            }
            healthStore.getAllBACData { result in
                allBACData = result
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct ChartView: UIViewRepresentable {
    var data: [Double]
    
    func makeUIView(context: Context) -> OCKCartesianChartView {
        let chartView = OCKCartesianChartView(type: .bar)
        chartView.headerView.titleLabel.text = "BAC Level"
        var dataSeries = OCKDataSeries(values: data.map { CGFloat($0) }, title: "BAC") //transform the data array by converting each element from Double to CGFloat
        dataSeries.gradientEndColor = UIColor(Color("Main"))
        dataSeries.gradientStartColor = UIColor(Color("Main"))
        chartView.graphView.dataSeries = [dataSeries]
        return chartView
    }

    func updateUIView(_ uiView: OCKCartesianChartView, context: Context){
        var dataSeries = OCKDataSeries(values: data.map { CGFloat($0) }, title: "BAC")
        dataSeries.gradientEndColor = UIColor(Color("Main"))
        dataSeries.gradientStartColor = UIColor(Color("Main"))
        uiView.graphView.dataSeries = [dataSeries]
    }
}




