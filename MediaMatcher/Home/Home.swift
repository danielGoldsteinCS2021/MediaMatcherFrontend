//
//  Home.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI

struct Home : View {
    
    @State var movies = [
        Movie(id: 0, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 1, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 2, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 3, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 4, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
        Movie(id: 5, name: "The Social Network", image: "p0", actor: " Jesse Eisenberg, Andrew Garfield, Justin Timberlake and more...", genre: "Biography, Drama", synopsis: "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.", offset: 0),
    ]
    @Binding var details: Bool // when true shows the description of movie    
    var body: some View{
        VStack{
            if !details {
                HStack(spacing: 15){ // this is the top title/menu bar
                    Button(action: {}, label: {
                        Image(systemName: "text.justify")
                            .renderingMode(.template)
                    })
                    Text("Media Matcher")
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
