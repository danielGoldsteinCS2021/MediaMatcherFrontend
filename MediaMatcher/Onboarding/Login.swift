//
//  Login.swift
//  Team
//
//  Created by Harin Wu on 2021-01-15.
//

import SwiftUI


struct Login : View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var login: Bool

    var body: some View {
        VStack {
            Image("fridgeSpace2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 80)
                .padding(.bottom, 20)

            VStack(spacing: 25) {
                TextField("    Username", text: $username)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("    Password", text: $password)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            
            Button(action: {
                login.toggle()
            }) {
                HStack {
                    Text("Login")
                        .foregroundColor(Color(hex: "#fff"))
                        .padding([.vertical],15)
                        .frame(width:260)
                }.background(Color(hex: "#B03838"))
                .cornerRadius(10)
            }.padding(.top, 40)
            
        }
    }
}

