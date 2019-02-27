//
//  WelcomeViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var flashChatLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        flashChatLabel.center.x -= flashChatLabel.bounds.width
        flashChatLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.flashChatLabel.center.x += self.flashChatLabel.bounds.width
            self.flashChatLabel.alpha = 1
        }, completion: nil)
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
