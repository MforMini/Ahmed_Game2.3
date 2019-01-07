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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startLocation = touches.first?.location(in:self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentLocation = touches.first?.location(in:self)
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        
        self.center = CGPoint(x: self.center.x+dx, y:self.center.y+dy)
    }


}
