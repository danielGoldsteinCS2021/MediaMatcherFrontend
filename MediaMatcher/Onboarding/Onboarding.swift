//
//  Onboarding.swift
//  Team
//
//  Created by Victor Uemura on 2021-01-16.
//

import SwiftUI

struct Onboarding: View {
    let titles = ["Create", "Swipe", "Match", "Profile"]
    let bodies = ["Make a room \nfor your friends to join", "Right means yes \nLeft means no","We will find a movie \nthe whole room will enjoy", "Customize your profile\n"]
    @State var slide = 0
    @Binding var login: Bool

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: Login(login: $login)) {
                        Text("Login")
                            .foregroundColor(Color(hex: "#B03838"))
                    }
                }.padding([.trailing, .top], 30)
                Spacer()
                if slide == 0 {
                    Rectangle().fill(Color.clear).frame(height: 60)
                    Text("Welcome to")
                        .foregroundColor(Color(hex: "#B03838"))
                        .font(.body)
                        .padding(.bottom, 5)
                        .padding(.top,22)
                        .offset(y:90)
                }
                else {
                Text(titles[slide-1])
                    .foregroundColor(Color(hex: "#B03838"))
                    .font(.title)
                    .padding(.bottom, 20)
                Text(bodies[slide-1])
                    .foregroundColor(Color(hex: "#B03838"))
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                }
                ImageSlider(slide: $slide).offset(y:-50)
                NavigationLink(destination: Register(login: $login)) {
                    HStack {
                        Text("Sign up")
                            .foregroundColor(Color(hex: "#fff"))
                            .padding([.vertical],20)
                            .frame(width:220)
                    }.background(Color(hex: "#B03838"))
                }.cornerRadius(30).padding(.top, 20)
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }.accentColor( Color(hex: "#B03838"))
    }
}

struct ImageSlider: View {
    @Binding var slide : Int
    var body: some View {
        ZStack {
            PagerView(pageCount: 5, currentIndex: $slide) {
            Image("fridgeSpace")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 100, height: 350)
            Image("onboarding0")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 350)
            Image("onboarding1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 350)
            Image("onboarding2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 350)
            Image("onboarding3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 350)
            }.frame(height: 350)
            VStack {
                Spacer()
                HeaderBar(capsuleColor: Color(hex: "#E8E8E8"), highlightColor: Color(hex: "#B03838"),slide: $slide, total: 5)
            }.frame(width: 350, height: 350)
        }
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}

