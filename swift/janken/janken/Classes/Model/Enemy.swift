//
//  Enemy.swift
//  janken
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation
import Unbox

struct Enemy {
    let hand: Int
}

extension Enemy: Unboxable {
    init(unboxer: Unboxer) throws {
        self.hand = try unboxer.unbox(key: "hand")
    }
}
