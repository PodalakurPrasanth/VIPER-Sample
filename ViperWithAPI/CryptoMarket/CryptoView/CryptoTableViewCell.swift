//
//  CryptoTableViewCell.swift
//  ViperWithAPI
//
//  Created by gurajala srikanth on 02/04/22.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var cryptoPriceLabel: UILabel!
    @IBOutlet weak var cryptoNameLabel: UILabel!
    @IBOutlet weak var crypto24ThLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
