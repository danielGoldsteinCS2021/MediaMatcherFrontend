//
//  Match.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-04-01.
//

import SwiftUI

struct Match : View {
    @State var movie : Movie
    @Binding var match: Bool
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Image(movie.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: .infinity)
            LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.8)]), startPoint: .center, endPoint: .bottom) //gradient to help text more readible on image
            VStack(spacing: 15){
                HStack{
                    VStack(alignment: .leading,spacing: 12){
                        Text(movie.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(movie.synopsis)
                        Text("Watch Now")
                            .font(.title2)
                            .bold()
                        HStack {
                            VStack {
                                Image("netflix")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                Text("Netflix")
                            }
                            Spacer()
                            VStack {
                                Image("prime")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .grayscale(0.99)
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                Text("Prime")
                            }
                            Spacer()
                            VStack {
                                Image("hulu")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .grayscale(0.99)
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                Text("Hulu")
                            }
                            Spacer()
                            VStack {
                                Image("crave")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .grayscale(0.99)
                                    .frame(width: 55, height: 55)
                                    .clipShape(Circle())
                                Text("Crave")
                            }
                            
                        }.padding(.horizontal, 15)
                    }
                    .foregroundColor(Color.black)

                    Spacer(minLength: 0)
                }
            }
            .padding(.all, 20)
            .padding(.bottom, 10)
            .background(Color.white)
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
                            match = false
                        }
                        else if movie.offset < -150{
                            movie.offset = -500
                            match = false
                        }
                        else{
                            movie.offset = 0
                        }
                })
        )
    }
}
