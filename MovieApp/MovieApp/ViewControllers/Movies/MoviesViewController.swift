//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var moviesViewModel = MoviesViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        // Do any additional setup after loading the view.
        setupBindings()
        moviesViewModel.requestData()
    }

    func setupBindings() {
        // Error Handling
        moviesViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                self.alert.setMessage(error)
                self.alert.show()
            })
            .disposed(by: disposeBag)

        // Movies CollectionView
        moviesViewModel
            .sources
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView
                    .rx
                    .items(cellIdentifier: "MoviesCollectionViewCell", cellType: MoviesCollectionViewCell.self)) { _, element, cell in
                cell.configure(with: element)
            }.disposed(by: disposeBag)

        let flowLayout = UICollectionViewFlowLayout()
        let width = (view.frame.size.width/2) - 8
        let height = width*3/2 + 80
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)

        // CollectionView Pagination
        collectionView
            .rx
            .didScroll
            .subscribe { [unowned self] _ in
                if self.collectionView.contentOffset.y > (self.collectionView.contentSize.height - self.collectionView.frame.size.height - 100) {
                    self.moviesViewModel.requestData()
                }
            }
            .disposed(by: disposeBag)

        // CollectionView Selections
        collectionView
            .rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { [unowned self] model in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let headlinesViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController")
                    as? MovieDetailViewController {
                    headlinesViewController.movie = model
                    self.navigationController?.pushViewController(headlinesViewController, animated: true)
                }
            }).disposed(by: disposeBag)

        // Handle Loading View
        moviesViewModel
            .isLoading
            .subscribe { [unowned self] avaliable in
            guard let avaliable = avaliable.element else { return }
                self.indicatorContainerView.isHidden = !avaliable
                avaliable ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
        .disposed(by: disposeBag)
    }

}
