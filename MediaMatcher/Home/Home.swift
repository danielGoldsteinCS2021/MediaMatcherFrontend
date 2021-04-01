//
//  Home.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI

struct Home : View {
    @State var movies = [
        Movie(id: 0, name: "The Social Network", image: "p0", actor: "Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 1, name: "Saving Private Ryan", image: "p1", actor: "Tom Hanks, Matt Damon, Tom Sizemore and more...", genre: "Drama, War", synopsis: "Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.", offset: 0),
        Movie(id: 2, name: "The Green Mile", image: "p2", actor: "Tom Hanks, Michael Clarke Duncan, David Morse and more...", genre: "Drama", synopsis: "The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder, yet who has a mysterious gift.", offset: 0),
        Movie(id: 3, name: "The Godfather", image: "p3", actor: "Marlon Brando, Al Pacino, James Caan and more...", genre: "Comedy, Crime, Drama", synopsis: "An organized crime dynasty's aging patriarch transfers control of his clandestine empire to his reluctant son.", offset: 0),
        Movie(id: 4, name: "Knives Out", image: "p4", actor: "Daniel Craig, Chris Evans, Ana de Armas and more...", genre: "Biography, Drama", synopsis: "A detective investigates the death of a patriarch of an eccentric, combative family.", offset: 0),
        Movie(id: 5, name: "Parasite", image: "p5", actor: "Kang-ho Song, Lee Sun-kyun, Cho Yeo-jeong and more...", genre: "Drama, Thriller", synopsis: "Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.", offset: 0),
    ]
    @Binding var details: Bool // when true shows the description of movie
    @Binding var showRoomInfo: Bool
    var body: some View{
        VStack{
            if !details {
                HStack(spacing: 15){ // this is the top title/menu bar
                    Button(action: {
                        showRoomInfo = true
                    }, label: {
                        Image(systemName: "info.circle")
                            .renderingMode(.template)
                            .foregroundColor(Color(hex: "B03838"))
                    })
                    Text("MovieMatcher")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "B03838"))
                    Spacer(minLength: 0)
                }
                .foregroundColor(.black)
                .padding()
            }
            GeometryReader{g in // g is an object that has the remainder of space in the view, which is what we pass to movieview
                ZStack{
                    ForEach(movies.reversed()){movie in //reverse so top card is most recent movie
                        MovieView(movie: movie, details: $details, frame: g.frame(in: .global))
                            .edgesIgnoringSafeArea(.all) //let card expand to full screen
                    }
                }
            }
            .padding([.horizontal, .bottom], details ? 0 : 20)
            .animation(.easeInOut(duration: 0.6)) // animation for view
        }
        .background(Color(hex: "#f0e9e6").edgesIgnoringSafeArea(.all))
    }
}
