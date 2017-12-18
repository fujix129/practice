//
//  ViewController.swift
//  janken
//
//  Created by fujix on 2017/12/15.
//  Copyright © 2017年 fujix. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import Unbox

class results: Object {
    @objc dynamic var win = Int()
    @objc dynamic var lose = Int()
    @objc dynamic var drow = Int()
}

class ViewController: UIViewController {

    @IBOutlet weak var hands_result: UITextField!
    @IBOutlet weak var janken_result: UILabel!

    @IBOutlet weak var Win_count: UILabel!
    @IBOutlet weak var Lose_count: UILabel!
    @IBOutlet weak var Drow_count: UILabel!

    var win = 0;
    var lose = 0;
    var drow = 0;
    
    func history (hist:Int) {
        if hist == 0 {
            win += 1;
            Win_count.text = "\(win)勝ち";
        }else if hist == 1 {
            lose += 1;
            Lose_count.text = "\(lose)負け";
        }else{
            drow += 1;
            Drow_count.text = "\(drow)引分";
        }
    }

    func reset () {
        win = 0;
        lose = 0;
        drow = 0;
        Win_count.text = "\(win)勝ち";
        Lose_count.text = "\(lose)負け";
        Drow_count.text = "\(drow)引分";
    }
    
    func result (hand:Int,cpu:Int){
        var hands = ["ぐー","ちょき","ぱー"];
//        let cpu = (Int)(arc4random_uniform(3));
//        let cpu = randam_hands()
        hands_result.text = "あなた:\(hands[hand])    CPU:\(hands[cpu])";
        if (hand == 0 && cpu == 1 ) || ( hand == 1 && cpu == 2 ) || ( hand == 2 && cpu == 0 ) {
            janken_result.text = "YOU WIN";
            history(hist:0)
        } else if ( hand == cpu){
            janken_result.text = "DROW!!";
            history(hist:2);
        } else{
            janken_result.text = "YOU LOSE!!";
            history(hist:1);
        }
    }

    func randam_hands (hand:Int) {
        var enemy:Enemy? = nil
        Alamofire.request("https://xsota.github.io/janken-api-stub-/enemy.json").responseJSON{ response in
            let hoge = response.result.value as! Dictionary <String,Int>
            
            do {
                enemy = try unbox(dictionary:hoge as! UnboxableDictionary)
                self.result(hand:hand,cpu:enemy!.hand)
            }catch{
                print(error)
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        let result = results()
        result.win = win
        result.lose = lose
        result.drow = drow
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            realm.add(result)
        }
    }
    
    
    @IBAction func result_reset(_ sender: Any) {
        reset()
    }

    @IBAction func tap_goo(_ sender: Any) {
        randam_hands(hand:0)
        
        //        result(hand:0)
    }
    
    @IBAction func tap_choki(_ sender: Any) {
        randam_hands(hand:1)
//        result(hand:1)
    }
    
    @IBAction func tap_per(_ sender: Any) {
        randam_hands(hand:2)
//        result(hand:2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let realm = try! Realm()
        let hoge = realm.objects(results.self)
        Win_count.text = "\(hoge[0].win)勝ち";
        win = hoge[0].win
        Lose_count.text = "\(hoge[0].lose)負け";
        lose = hoge[0].lose
        Drow_count.text = "\(hoge[0].drow)引分";
        drow = hoge[0].drow
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

