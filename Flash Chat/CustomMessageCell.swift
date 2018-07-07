//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Abdullah Alhaider on 12/14/17.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
    }
}
