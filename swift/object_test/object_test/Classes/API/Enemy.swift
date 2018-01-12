//
//  Enemy.swift
//  object_test
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

struct Enemyhand {
    var hand: Int
}

extension Enemyhand: Unboxable {
    init(unboxer: Unboxer) throws {
        self.hand = try unboxer.unbox(key: "hand")
    }
}

class Enemy {
    func randomHands () -> Int{
        var enemyHand:Enemyhand? = nil
        Alamofire.request("https://xsota.github.io/janken-api-stub-/enemy.json").responseJSON{ response in
            let hoge = response.result.value as! Dictionary <String,Int>
            
            do {
                enemyHand = try unbox(dictionary:hoge as! UnboxableDictionary)
            }catch{
                print(error)
            }
        }
        return enemyHand!.hand
    }
}
