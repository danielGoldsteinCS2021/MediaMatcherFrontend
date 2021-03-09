//
//  RoomCode.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-03-08.
//

import SwiftUI

struct RoomCode: View {
    @State private var roomCode: String = ""
    @Binding var roomEntered: Bool
    var body: some View {
        VStack {
            Text("Enter Room Code")
                .font(.largeTitle)
                .padding(.top, 60)
            TextField("                 Room Code", text: $roomCode)
                .frame(width: 260,height:30)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                roomEntered.toggle()
            }) {
                HStack {
                    Text("Enter")
                        .foregroundColor(Color(hex: "#fff"))
                        .padding([.vertical],15)
                        .frame(width:260)
                }.background(Color(hex: "#255359"))
                .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.bottom, 60)
        }
        .background(Rectangle().frame(width: UIScreen.main.bounds.width - 40).foregroundColor(.white).cornerRadius(10).shadow(radius: 5))
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
