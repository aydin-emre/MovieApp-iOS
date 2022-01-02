//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Emre on 1.01.2022.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var favoriteContainerView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!

    private var movie: Movie?
    public var isFavorite: Bool = false {
        didSet {
            favoriteImageView.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
        self.round(masksToBounds: true)
        rateLabel.round(radius: 22, masksToBounds: true)
        rateLabel.addBorder(color: .white, radius: 22, borderWidth: 2)
        favoriteContainerView.round(radius: 22, masksToBounds: true)
        favoriteContainerView.addBorder(color: .white, radius: 22, borderWidth: 2)
        favoriteContainerView.backgroundColor = appColor
        favoriteContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteButtonClicked)))
    }

    func configure(with movie: Movie) {
        self.movie = movie
        if let url = URL(string: posterImageUrlPrefix+movie.posterPath) {
            imageView.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = movie.title
        dateLabel.text = movie.releaseDate
        rateLabel.text = String(movie.voteAverage)
        DatabaseManager.shared.checkFavorites(movie: movie) { contains in
            self.isFavorite = contains
        }
    }

    @objc func favoriteButtonClicked() {
        isFavorite ? DatabaseManager.shared.removeFromFavorites(movie: movie) : DatabaseManager.shared.addToFavorites(movie: movie)
        isFavorite = !isFavorite
    }

}
