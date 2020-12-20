//
//  DiscoverCell.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 17/12/20.
//

import UIKit
import Kingfisher

class DiscoverCell: UITableViewCell {

    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with movie: Movie) {
        labelMovieName.text = movie.title
        labelMovieYear.text = movie.releaseDate.getYear()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)") else { return }
        imageViewMovie.kf.setImage(with: url)
    }
}
