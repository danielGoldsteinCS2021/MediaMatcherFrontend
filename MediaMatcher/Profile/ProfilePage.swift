//
//  Profile.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-03-08.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var offset: CGSize
    @Binding var showHome: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring()){
                        offset = .zero
                        showHome.toggle()
                    }
                }) {
                    Image(systemName: "multiply")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            Image("max")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text("Max Eisen")
                .bold()
                .font(.largeTitle)
            HStack {
                Text("Enjoys company from husky men")
            }
            Spacer()
        }
        .padding(.top, 70)
        .padding(.horizontal, 20)
    }
}
