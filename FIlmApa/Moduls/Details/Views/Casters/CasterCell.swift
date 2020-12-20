//
//  CasterCell.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 18/12/20.
//

import UIKit
import Kingfisher

class CasterCell: UICollectionViewCell {

    @IBOutlet weak var imageViewPerson: UIImageView!
    @IBOutlet weak var labelNamePerson: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(with caster: Cast) {
        labelNamePerson.text = caster.name
        if let path = caster.profilePath {
            guard let profileUrl = URL(string: "https://image.tmdb.org/t/p/w185/\(path)") else { return }
            imageViewPerson.kf.setImage(with: profileUrl)
        }
    }

}
