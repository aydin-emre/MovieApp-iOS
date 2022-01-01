//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Emre on 1.01.2022.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
        self.round(masksToBounds: true)
        rateLabel.round(radius: 22, masksToBounds: true)
        rateLabel.addBorder(color: .white, radius: 22, borderWidth: 2)
    }

    func configure(with movie: Movie) {
        if let url = URL(string: posterImageUrlPrefix+movie.posterPath) {
            imageView.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        rateLabel.text = String(movie.voteAverage)
    }

}
