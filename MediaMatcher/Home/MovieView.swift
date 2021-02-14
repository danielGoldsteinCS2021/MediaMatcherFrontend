//
//  ProfileView.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI

struct MovieView : View {
    @State var movie : Movie
    @Binding var details : Bool
    var frame : CGRect
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Image(movie.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: details ? UIScreen.main.bounds.width : frame.width, height: details ? .infinity : frame.height)
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: { // like or reject overlay
                (movie.offset > 0 ? Color.green : Color.red)
                    .opacity(movie.offset != 0 ? 0.7 : 0)
                HStack{
                    if movie.offset < 0{ // pushs text to right
                        Spacer()
                    }
                    Text(movie.offset == 0 ? "" : (movie.offset > 0 ? "Liked" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .padding(.horizontal)
                    if movie.offset > 0 { // pushs text to left
                        Spacer()
                    }
                }
            })
            if !details {
                LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.8)]), startPoint: .center, endPoint: .bottom) //gradient to help text more readible on image
            }
            VStack(spacing: 15){
                HStack{
                    VStack(alignment: .leading,spacing: 12){
                        Text(movie.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(movie.actor)
                            .fontWeight(details ? .none : .bold)
                        Text(movie.genre)
                            .fontWeight(details ? .none : .bold)
                        if details {
                            Text("Synopsis")
                                .fontWeight(.bold)
                            Text(movie.synopsis)
                        }
                    }
                    .foregroundColor(details ? Color.black : Color.white)

                    Spacer(minLength: 0)
                }

                if !details {
                    HStack(spacing: 35){
                        Spacer(minLength: 0)
                        Button(action: {
                                movie.offset = -500
                                details = false
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.all,20)
                                .background(Color.red)
                                .clipShape(Circle())
                        })
                        Button(action: {
                                movie.offset = 500
                                details = false
                        }, label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(.all,20)
                                .background(Color.green)
                                .clipShape(Circle())
                        })
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.all, 20)
            .padding(.bottom, details ? 10 : 0)
            .background(details ? Color.white : Color.clear)
        })
        .cornerRadius(20)
        .offset(x: movie.offset)
        .rotationEffect(.init(degrees: movie.offset == 0 ? 0 : (movie.offset > 0 ? 12 : -12))) // tilt cards
        .gesture(
            DragGesture()
                .onChanged({ (value) in
                        movie.offset = value.translation.width
                })
                .onEnded({ (value) in
                        if movie.offset > 150{ // threshold for swipe
                            movie.offset = 500
                            details = false
                        }
                        else if movie.offset < -150{
                            movie.offset = -500
                            details = false
                        }
                        else{
                            movie.offset = 0
                        }
                })
        )
        .onTapGesture {
            details.toggle() //show details
        }
    }
}

