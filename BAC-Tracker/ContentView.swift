//
//  ContentView.swift
//  BAC-Tracker
//
//  Created by Anthony Sky Ng-Thow-Hing on 5/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem(){
                    Image(systemName: "house.fill") //SF SYMBOLS
                    Text("Home")
                }
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
