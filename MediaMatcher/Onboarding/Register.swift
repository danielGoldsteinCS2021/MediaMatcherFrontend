//
//  Login2.swift
//  Team
//
//  Created by Victor Uemura on 2021-01-16.
//

import SwiftUI

struct Register: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
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
                TextField("    Email", text: $email)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("    Password", text: $password)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("    Confirm Password", text: $password2)
                    .frame(width: 260,height:30)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                login.toggle()
            }) {
                HStack {
                    Text("Sign up")
                        .foregroundColor(Color(hex: "#fff"))
                        .padding([.vertical],15)
                        .frame(width:260)
                }.background(Color(hex: "#255359"))
                .cornerRadius(10)
            }.padding(.top, 20)
            
            Text("OR")
                .foregroundColor(Color(hex: "#255359"))
                .font(.body)
                .padding(10)

        }
    }
}
