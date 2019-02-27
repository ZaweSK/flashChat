//
//  WelcomeViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var animationHasBeenShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet var flashChatLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        if !animationHasBeenShown{
            flashChatLabel.center.x -= flashChatLabel.bounds.width
            flashChatLabel.alpha = 0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !animationHasBeenShown{
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
                self.flashChatLabel.center.x += self.flashChatLabel.bounds.width
                self.flashChatLabel.alpha = 1
            }, completion: nil)
            
         animationHasBeenShown = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
