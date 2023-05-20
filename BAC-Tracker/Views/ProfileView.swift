//
//  ProfileView.swift
//  BAC-Tracker
//
//  Created by Anthony Sky Ng-Thow-Hing on 5/18/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            
            Text("This is your profile!")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
