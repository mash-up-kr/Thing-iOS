//
//  YoutuberDescriptionTableViewCell.swift
//  thing
//
//  Created by 이호찬 on 2019/06/30.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit

class YoutuberDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
}

extension YoutuberDescriptionTableViewCell {
    func configure(description: String?) {
        descriptionLabel.text = description
    }
}
