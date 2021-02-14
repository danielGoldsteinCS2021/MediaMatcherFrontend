//
//  Profile.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-02-12.
//

import SwiftUI

struct Movie : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var actor : String
    var genre : String
    var synopsis : String
    var offset : CGFloat
}
