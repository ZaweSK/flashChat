//
//  CustomMessageCell.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var senderUsername: UILabel!
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var messageBody: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
