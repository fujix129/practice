//
//  Enemy.swift
//  object_test
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation
import Unbox

class Enemy {
    
    extension Enemy: Unboxable {
        init(unboxer: Unboxer) throws {
            self.hand = try unboxer.unbox(key: "hand")
        }
    }
    
    struct Enemy {
        let hand: Int
    }
    
    func gets ()->Int {
        
        return 1
    }
}
