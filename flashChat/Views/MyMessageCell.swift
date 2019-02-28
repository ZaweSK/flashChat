//
//  MyMessageCell.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation
import UIKit

class MyMessageCell : UITableViewCell {
    
    @IBOutlet var messageBackground: UIView!
    
    @IBOutlet var messageBody: UILabel!
    
    @IBOutlet var senderName: UILabel!
    
    @IBOutlet var avatarImageView: UIImageView!
}
