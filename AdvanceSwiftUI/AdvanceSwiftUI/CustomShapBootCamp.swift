//
//  CustomShapBootCamp.swift
//  AdvanceSwiftUI
//
//  Created by Vipal on 13/10/22.
//

import SwiftUI

/*
                            Xmid
    xmin . . . . . . . . . . . . . . . . . . . . .xmax
    Ymin .
         .
         .
         .
         .
         .
         .
         .
         .
         .
         .
 Ymid    .
         .
         .
         .
         .
         .
         .
         .
         .
         .
         .Ymax
 */
struct Diamod :Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            //set the pointer
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY)) //Center point Or start point
            
            //Add Line
            path.addLine(to: CGPoint(x:rect.minX + 90, y:rect.midY ))
            path.addLine(to: CGPoint(x:rect.midX, y:rect.maxY ))
            path.addLine(to: CGPoint(x:rect.maxX - 90 , y:rect.midY ))
            
            

   
        
        }
    }
}
struct Tringle :Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            //set the pointer
            path.move(to: CGPoint(x: rect.midX, y: rect.midY)) //Center point Or start point
            
            //Add Line
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x:rect.minX, y: rect.maxY))

     
        }
    }
}
struct CustomShapBootCamp: View {
    var body: some View {
        Tringle()
            .frame(width: 400,height: 400)
    }
}

struct CustomShapBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapBootCamp()
    }
}
