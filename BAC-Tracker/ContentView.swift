//
//  ContentView.swift
//  BAC-Tracker
//
//  Created by Anthony Sky Ng-Thow-Hing on 5/18/23.
// CUSTOM TABBAR

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack{
            // Your main content view here
            VStack{
                selectedTabView()
                Rectangle()
                    .frame(height:50)
                    .colorInvert()
        
            }
            VStack {
                Spacer()
                // Custom tab bar
                HStack {
                    Spacer()
                    TabBarItem(selectedTab: $selectedTab, index: 0, systemName: "house")
                    Spacer()
                    TabBarItem(selectedTab: $selectedTab, index: 1, systemName: "person.crop.circle")
                    Spacer()
                }
                .frame(height: 100)
                .background(Color.white)
                .cornerRadius(200)
            }
    }
    }
    
    @ViewBuilder
    func selectedTabView() -> some View {
        switch selectedTab {
        case 0:
            HomeView()
        case 1:
            ProfileView()
        default:
            HomeView()
        }
    }
}

struct TabBarItem: View {
    @Binding var selectedTab: Int
    let index: Int
    let systemName: String
    var body: some View {
        VStack {
            Image(systemName: selectedTab == index ? "\(systemName).fill" : systemName)
                .imageScale(.large)
                .padding(.bottom, 1)
                .foregroundColor(selectedTab == index ? Color("Main") : .gray) // Change color based on selection status

            Text(index == 0 ? "Home" : "Profile")                .foregroundColor(selectedTab == index ? Color("Main") : .gray) // Change color based on selection status
                .font(.caption)
        }
        .padding()
        .onTapGesture {
            selectedTab = index
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
