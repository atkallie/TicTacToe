//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ahmed T Khalil on 1/8/17.
//  Copyright © 2017 kalikans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Note that ALL 9 of the buttons are connected to a single IBAction since each button will do the same thing; you need to change default sender type of 'Any' to 'AnyObject' to do this
    
    //play again button to show at end of game
    @IBOutlet var playAgain: UIButton!
    
    //display who wins when game ends
    @IBOutlet var gameOverLabel: UILabel!
   
    //counter will be used to alternate between which image is displayed
    var counter: Int = 0
    
    //initialize winning sets
    let winning: [[Int]] = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    //keep track of clicked X's and O's
    var arrX = [Int]()
    var arrO = [Int]()
    
    //to prevent double clicking of same box
    var notClickedAlready: Bool = true
    
    //check if game is over
    var gameOver: Bool = false
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        //note that that the '-1' for the indices is due to dumb tagging; I put in 1 for the first tag and indexing starts at 0 (derp)
        //if the button has been clicked already
        //check if button index is in the X array
        for i in arrX{
            if i == (sender.tag!-1){
                notClickedAlready = false
                break
            }
        }
        //check if button index is in the O array
        for i in arrO{
            if i == (sender.tag!-1){
                notClickedAlready = false
                break
            }
        }
        
        
        if counter % 2 == 0 && notClickedAlready{
            UIView.animate(withDuration: 0.1, animations: {
                sender.setImage((UIImage(named: "nought.png")), for: [])
            })
            
            arrO.append(sender.tag!-1)
            
            counter+=1
        }else if counter % 2 != 0 && notClickedAlready{
            UIView.animate(withDuration: 0.1, animations: {
                sender.setImage((UIImage(named: "cross.png")), for: [])
            })
            
            arrX.append(sender.tag!-1)
            
            counter+=1
        }
        
        //check to see if any of the winning sets is a subset of the clicked X or O arrays
        for i in winning{
            if Set(i).isSubset(of: Set(arrO)){
                gameOverLabel.text = "O Wins!"
                gameOver = true
                break
            }else if Set(i).isSubset(of: Set(arrX)){
                gameOverLabel.text = "X Wins!"
                gameOver = true
                break
            }
        }

        //if the game is over, then don't allow any more clicking. otherwise, reset the notClickedAlready variable for the next turn
        if gameOver{
            notClickedAlready=false
            
            //show play again button if the game is over
            playAgain.isHidden = false
        }else{
            notClickedAlready=true
        }
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        //reset clicked arrays
        arrX.removeAll()
        arrO.removeAll()
        
        //reset gameOver, notClickedAlready, and counter values
        gameOver = false
        notClickedAlready = false
        counter = 0
        
        //reset images
        for i in 1...9{
            //to do this, cast the general UIView element to a UIButton in order to get button-specific methods
            if let button = view.viewWithTag(i) as? UIButton{
                //then set the images to nil
                button.setImage(nil, for: [])
            }
        }
        
        
        //finally hide the play again button and reset the game over label
        playAgain.isHidden = true
        gameOverLabel.text = ""
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgain.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

