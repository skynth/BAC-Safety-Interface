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
            
            VStack {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Main"))
                    .padding(.bottom, 50)
                    .padding(.top, 50)
                HStack{
                    Image(systemName : "ruler")
                        .rotationEffect(Angle(degrees : 45))
                        .imageScale(.large)
                        .padding(.leading, 30)
                        .padding(.bottom, 15)
                    Text("Update Height")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                        .padding(.bottom, 15)
                    Spacer()
                }
                Rectangle()
                    .frame(height : 1)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 15)
                HStack{
                    Image(systemName : "scalemass")
                        .imageScale(.large)
                        .padding(.leading, 30)
                        .padding(.bottom, 15)
                    Text("Update Weight")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                        .padding(.bottom, 15)
                    Spacer()
                }
                Rectangle()
                    .frame(height : 1)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 15)
                HStack{
                    Image(systemName : "person")
                        .imageScale(.large)
                        .padding(.leading, 30)
                        .padding(.bottom, 30)
                    Text("Update Sex")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                        .padding(.bottom, 30)
                    Spacer()
                }
            Spacer()
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
