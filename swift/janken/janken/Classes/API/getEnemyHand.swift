//
//  getEnemyHand.swift
//  janken
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class Enemyhand {
    func get () {
        var enemy:Enemy? = nil
        Alamofire.request("https://xsota.github.io/janken-api-stub-/enemy.json").responseJSON{ response in
            let hoge = response.result.value as! Dictionary <String,Int>
            
            do {
                enemy = try unbox(dictionary:hoge as! UnboxableDictionary)
//                self.result(hand:hand,cpu:enemy!.hand)
            }catch{
                print(error)
            }
        }
    }
}


