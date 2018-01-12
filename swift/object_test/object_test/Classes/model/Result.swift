//
//  Result.swift
//  object_test
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation

class Result{
    func replace(hand:Int,enemy:Int)->String{
        var hoge="あいうえお"
        if (hand == 0 && enemy == 1) || (hand == 1 && enemy == 2) || (hand == 2 && enemy == 0 ){
            hoge = "YOU WIN"
        } else if (hand == enemy){
            hoge = "DROW"
        } else {
            hoge = "YOU LOSE"
        }
        return hoge
    }
}

