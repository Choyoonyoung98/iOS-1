//
//  CommunityOneTVC.swift
//  DowaDog
//
//  Created by wookeon on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class CommunityOneTVC: UITableViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userId: UILabel!
    @IBOutlet var writeTime: UILabel!
    @IBOutlet var uploadImage1: UIImageView!
    @IBOutlet var title: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}