//
//  Movement.swift
//  Ahmed_Game
//
//  Created by ah18acv on 05/11/2018.
//  Copyright © 2018 CSStestuser. All rights reserved.
//

import UIKit

class Movement: UIImageView {

    var startLocation: CGPoint?
    var delegate: subviewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startLocation = touches.first?.location(in:self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentLocation = touches.first?.location(in:self)
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        var newcenter = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
        //Constraining movement 
        let halfx = self.bounds.midX
        newcenter.x = max (halfx, newcenter.x)
        newcenter.x = min (self.superview!.bounds.size.width - halfx,newcenter.x)
        
        let halfy = self.bounds.midX
        newcenter.y = max (halfy, newcenter.y)
        newcenter.y = min (self.superview!.bounds.size.width - halfy,newcenter.y)
        
        self.center = newcenter
        
        self.delegate?.changeSomething()
    }


}
