//
//  LiquidSwipe.swift
//  MediaMatcher
//
//  Created by Victor Uemura on 2021-03-08.
//

import SwiftUI

struct LiquidSwipe: Shape {
    
    var offset: CGSize
    
    var animatableData: CGSize.AnimatableData{
        get{return offset.animatableData}
        set{offset.animatableData = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        if offset == CGSize(width: 999999, height: 999999) {
            return Path {path in
                let width = rect.width + (-offset.width > 0 ? offset.width : 0)
                
                //rectangle shape
                path.move(to: CGPoint(x: 0, y: -44))
                path.addLine(to: CGPoint(x: rect.width, y: -44))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height + 33))
                path.addLine(to: CGPoint(x: 0, y: rect.height + 33))
            }
        }
        else {
            return Path {path in
                let width = rect.width + (-offset.width > 0 ? offset.width : 0)
                
                //rectangle shape
                path.move(to: CGPoint(x: 0, y: -44))
                path.addLine(to: CGPoint(x: rect.width, y: -44))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height + 33))
                path.addLine(to: CGPoint(x: 0, y: rect.height + 33))

                //curve shape
                //from
                let from = offset.width - 15
                path.move(to: CGPoint(x:rect.width, y: from > 80 ? 80 : from))
                
                //to
                var to = 85 + offset.height + (-offset.width)
                to = to < 85 ? 85 : to

                //mid
                let mid : CGFloat = ((to - 15) / 2)
                path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
            }
        }
    }
}


