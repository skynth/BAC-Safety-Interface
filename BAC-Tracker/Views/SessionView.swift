//
//  SessionView.swift
//  BAC-Tracker
//
//  Created by Anthony Sky Ng-Thow-Hing on 5/19/23.
//

import SwiftUI

struct SessionView: View {
    @State private var bacInput: String = ""
    @State private var latestBAC: Double = 0.0
    @State private var allBACData: [Double] = []
    @ObservedObject private var healthStore = HealthStore()
    
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

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
                        healthStore.getLatestBAC { result in
                            latestBAC = result //update latestBAC
                        }
                        healthStore.getAllBACData { result in
                            allBACData = result //update AllBACData
                        }
                        bacInput = ""
                    }
                }) {
                    Text("End Session")
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
                .padding(.bottom, 50)

                
                HStack{
                    Text("Drink History")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark"))
                        .padding([.leading, .trailing], 20)
                    Spacer()
                }
            
            }
        }
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

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
