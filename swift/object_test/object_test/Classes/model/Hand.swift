//
//  hand.swift
//  object_test
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation

class Hands{
    var handsText = "て"
    func text(hand:Int)->String{
        switch hand {
        case 0:
            handsText = "ぐー"
        case 1:
            handsText = "ちょき"
        case 2:
            handsText = "ぱー"
        default:
            break
        }
        return handsText
    }
}
