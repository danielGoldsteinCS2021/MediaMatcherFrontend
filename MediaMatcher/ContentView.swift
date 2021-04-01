//
//  ContentView.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI
import ConfettiView


struct ContentView: View {
    @State var login = false
    @State var offset: CGSize = .zero
    @State var showHome = false
    @State var roomEntered = false
    @State var showRoomInfo = false
    @State var details = false // when true shows the description of movie
    @State var match = false
  var body: some View {
    return ZStack {
        Home(details: $details, showRoomInfo: $showRoomInfo, match: $match)
            .opacity(showHome ? 0 : 1)
            .offset(y: login ? 0 : 1000)
            .clipShape(details ? LiquidSwipe(offset: CGSize(width: 999999, height: 999999)) : LiquidSwipe(offset: offset))
            .overlay(
                Image(systemName: details ? "" : "person")
                    .font(.title)
                    .foregroundColor(Color(hex: "B03838"))
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
        if !roomEntered || showRoomInfo {
            withAnimation(.spring()) {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                            .edgesIgnoringSafeArea(.all)
            }
        }
        RoomCode(roomEntered: $roomEntered)
            .offset(y: roomEntered ? 1000 : 0)
        Onboarding(login: $login).ignoresSafeArea(.all, edges: .vertical).offset(y: login ? 1000 : 0)
        RoomInfo(showRoomInfo: $showRoomInfo)
            .offset(y: showRoomInfo ? 0 : 1000)
        if showHome {
            ProfilePage(offset: $offset, showHome: $showHome)
        }
        if match {
            Match(movie: Movie(id: 5, name: "Parasite", image: "p5", actor: "Kang-ho Song, Lee Sun-kyun, Cho Yeo-jeong and more...", genre: "Drama, Thriller", synopsis: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.", offset: 0), match: $match).edgesIgnoringSafeArea(.all)
        }

    }.animation(.easeInOut(duration: 0.6))
  }
}

//struct ContentView: View {
//
//    @State private var isShowingConfetti: Bool = false
//
//    var body: some View {
//
//        let confettiCelebrationView = ConfettiCelebrationView(isShowingConfetti: $isShowingConfetti, timeLimit: 1.0)
//
//        let playButton = Button(action: {
//            NotificationCenter.default.post(name: Notification.Name.playConfettiCelebration, object: Bool.self)
//        }) {
//            Text("Play Celebration!!")
//        }.transition(.slowFadeIn)
//
//        return ZStack {
//            if !isShowingConfetti { playButton }
//            confettiCelebrationView
//        }
//    }
//}

/// a timed celebration
struct ConfettiCelebrationView: View {

    @Binding var isShowingConfetti: Bool // true while confetti is displayed
    private var timeLimit: TimeInterval // how long to display confetti
    @State private var timer = Timer.publish(every: 0.0, on: .main, in: .common).autoconnect()

    init(isShowingConfetti: Binding<Bool>, timeLimit: TimeInterval = 1.5) {
        self.timeLimit = timeLimit
        _isShowingConfetti = isShowingConfetti
    }

    var body: some View {

        // define confetti cell elements & fadeout transition
        let confetti = ConfettiView( confetti: [
            .text("🎞️"),
            .text("🎬"),
            .text("🎥"),
            .text("🍿"),

            // if using SF symbols, UIImage takes systemName to build
        ]).transition(.slowFadeOut)

        return ZStack {
            // show either confetti or nothing
            if isShowingConfetti { confetti } else { EmptyView() }
        }.onReceive(timer) { time in
            // timer beat is one interval then quit the confetti
            self.timer.upstream.connect().cancel()
            self.isShowingConfetti = false
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name.playConfettiCelebration)) { _ in
            // got notification so do --> reset & play
            self.resetTimerAndPlay()
        }
    }

    // reset the timer and turn on confetti
    private func resetTimerAndPlay() {
        timer = Timer.publish(every: self.timeLimit, on: .main, in: .common).autoconnect()
        isShowingConfetti = true
    }

}

// notification to start timer & display the confetti celebration view
public extension Notification.Name {
    static let playConfettiCelebration = Notification.Name("play_confetti_celebration")
}

// fade in & out transitions for ConfettiView and Play button
extension AnyTransition {
    static var slowFadeOut: AnyTransition {
        let insertion = AnyTransition.opacity
        let removal = AnyTransition.opacity.animation(.easeOut(duration: 1.5))
        return .asymmetric(insertion: insertion, removal: removal)
    }

    static var slowFadeIn: AnyTransition {
        let insertion = AnyTransition.opacity.animation(.easeIn(duration: 1.5))
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

