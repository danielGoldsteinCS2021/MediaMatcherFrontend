//
//  ContentView.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI

struct ContentView: View {
    @State var login = false
    @State var offset: CGSize = .zero
    @State var showHome = false
    @State var roomEntered = false
    @State var details = false // when true shows the description of movie
  var body: some View {
    ZStack {
        Home(details: $details)
            .offset(y: login ? 0 : 1000)
            .clipShape(details ? LiquidSwipe(offset: CGSize(width: 999999, height: 999999)) : LiquidSwipe(offset: offset))
            .overlay(
                Image(systemName: details ? "" : "person")
                    .font(.title)
                    .frame(width: 50, height: 50)
                    .contentShape(Rectangle())
                    .gesture(DragGesture().onChanged({ (value) in
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                            offset = value.translation
                        }
                    }).onEnded({ (value) in
                        let screen = UIScreen.main.bounds
                        withAnimation(.spring()) {
                            if -offset.width > screen.width / 2 {
                                offset.width = -screen.height
                                showHome.toggle()
                            }
                            else {
                                offset = .zero
                            }
                        }
                    }))
                    .offset(x: 8, y: 10)
                    .opacity(offset == .zero ? 1 : 0)
                ,alignment: .topTrailing
            )
        if !roomEntered {
            withAnimation(.spring()) {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                            .edgesIgnoringSafeArea(.all)
            }
        }
        RoomCode(roomEntered: $roomEntered)
            .offset(y: roomEntered ? 1000 : 0)
        Onboarding(login: $login).ignoresSafeArea(.all, edges: .vertical).offset(y: login ? 1000 : 0)

        if showHome {
            ProfilePage(offset: $offset, showHome: $showHome)
        }
    }.animation(.easeInOut(duration: 0.6))
  }
}


