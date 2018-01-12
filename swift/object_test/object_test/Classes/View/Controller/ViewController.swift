//
//  ViewController.swift
//  object_test
//
//  Created by fujix on 2017/12/18.
//  Copyright © 2017年 fujix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerHand: UILabel!
    @IBOutlet weak var enemyHand: UILabel!
    @IBOutlet weak var jankenResult: UILabel!

    func tap(hand:Int){
        playerHand.text = Hands().text(hand:hand)
        let enemy = 1 //Enemy().randomHands()
        enemyHand.text = Hands().text(hand:enemy)
        jankenResult.text = Result().replace(hand:hand,enemy:enemy)
        

    }

    @IBAction func tapGoo(_ sender: Any) {
        tap(hand:0)
    }

    @IBAction func tapChoki(_ sender: Any) {
        tap(hand:1)
    }

    @IBAction func tapPer(_ sender: Any) {
        tap(hand:2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

