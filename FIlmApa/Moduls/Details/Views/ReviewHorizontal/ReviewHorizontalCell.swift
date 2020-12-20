//
//  ReviewHorizontalCell.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit

class ReviewHorizontalCell: UICollectionViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }

    
    func bind(with review: Review) {
        self.labelName.text = review.author
        labelContent.text = review.content
    }
}
