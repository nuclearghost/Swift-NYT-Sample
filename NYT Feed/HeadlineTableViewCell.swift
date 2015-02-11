//
//  HeadlineTableViewCell.swift
//  NYT Feed
//
//  Created by Mark Meyer on 2/11/15.
//  Copyright (c) 2015 Sharethrough. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
