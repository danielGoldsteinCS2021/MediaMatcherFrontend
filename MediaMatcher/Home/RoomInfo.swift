//
//  RoomInfo.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-04-01.
//

import SwiftUI

struct RoomInfo: View {
    @Binding var showRoomInfo: Bool
    var body: some View {
        VStack {
            VStack (spacing: 10) {
                Text("Room Info")
                    .font(.largeTitle)
                    .foregroundColor(Color(hex: "B03838"))
                    .padding(.top, 60)
                
                Text("Room Code: BlueSoupMarch")
                    .font(.body)
                    .foregroundColor(Color(hex: "B03838"))
                Text("People in Room: 3")
                    .font(.body)
                    .foregroundColor(Color(hex: "B03838"))
            }
            Button(action: {
                guard let url = URL(string: "https://www.movie-matcher.com/") else { return }
                let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
            }) {
                HStack {
                    Text("Share")
                        .foregroundColor(Color(hex: "#fff"))
                        .padding([.vertical],15)
                        .frame(width:260)
                }.background(Color(hex: "#B03838"))
                .cornerRadius(10)

            }
            .padding(.top, 20)
            Button(action: {
                showRoomInfo.toggle()
            }) {
                HStack {
                    Text("Close")
                        .foregroundColor(Color(hex: "#fff"))
                        .padding([.vertical],15)
                        .frame(width:260)
                }.background(Color(hex: "#B03838"))
                .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.bottom, 40)
        }
        .background(Rectangle().frame(width: UIScreen.main.bounds.width - 40).foregroundColor(.white).cornerRadius(10).shadow(radius: 5))
    }
}
