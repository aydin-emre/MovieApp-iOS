//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Emre on 2.01.2022.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(favoriteButtonClicked))
    }()

    var movie: Movie?
    public var isFavorite: Bool = false {
        didSet {
            favoriteBarButtonItem.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        // Do any additional setup after loading the view.
        setupViews()
    }

    func setupViews() {
        guard let movie = movie else { return }

        self.navigationItem.rightBarButtonItem  = favoriteBarButtonItem

        if let url = URL(string: backdropImageUrlPrefix+movie.backdropPath) {
            imageView.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground) { _, _, _ in
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
            } completed: { _, _, _, _ in
                self.activityIndicator.stopAnimating()
            }
        }
        titleLabel.text = movie.title
        dateLabel.text = "\(movie.releaseDate) • (\(movie.originalLanguage))"
        voteLabel.text = "\(movie.voteAverage) / \(movie.voteCount)"
        overviewLabel.text = movie.overview
    }

    @objc func favoriteButtonClicked() {
        isFavorite ? DatabaseManager.shared.removeFromFavorites(movie: movie) : DatabaseManager.shared.addToFavorites(movie: movie)
        isFavorite = !isFavorite
    }

}
