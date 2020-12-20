//
//  GenreCell.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

class GenreCell: UITableViewCell {

    @IBOutlet weak var labelGenreName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with genre: Genre) {
        labelGenreName.text = genre.name
    }
    
}
