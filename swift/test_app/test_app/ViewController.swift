//
//  ViewController.swift
//  test_app
//
//  Created by fujix on 2017/12/08.
//  Copyright © 2017年 fujix. All rights reserved.
//

import UIKit
import RealmSwift

class results: Object {
    @objc dynamic var win = Int()
    @objc dynamic var lose = Int()
    @objc dynamic var drow = Int()
}

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!

    @IBOutlet weak var janken_result: UILabel!
    
    @IBOutlet weak var Win_count: UILabel!
    @IBOutlet weak var Lose_count: UILabel!
    @IBOutlet weak var Drow_count: UILabel!

    var win = 0;
    var lose = 0;
    var drow = 0;

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

    struct RealmModel {
        struct realm{
            static var realmTry  = try!Realm()
            static var realmsset = results()
            static var usersSet = RealmModel.realm.realmTry.objects(results.self)
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

    @IBAction func Reset(_ sender: Any) {
        reset();
    }
    
    func result (hand:Int){
        var hands = ["ぐー","ちょき","ぱー"];
        var cpu = (Int)(arc4random_uniform(3));
        myTextField.text = "あなた:\(hands[hand])    CPU:\(hands[cpu])";

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
    
    @IBAction func tap_goo(_ sender: Any) {
        result(hand:0)
    }

    @IBAction func tap_choki(_ sender: Any) {
        result(hand:1)
    }

    @IBAction func tap_per(_ sender: Any) {
        result(hand:2)
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
