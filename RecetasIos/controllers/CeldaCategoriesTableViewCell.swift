//
//  CeldaCategoriesTableViewCell.swift
//  RecetasIos
//
//  Created by MarcosHernandez on 24/01/2024.
//

import UIKit

class CeldaCategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var imPhoto: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
