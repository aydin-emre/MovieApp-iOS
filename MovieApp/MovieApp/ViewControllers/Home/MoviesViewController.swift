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

    var moviesViewModel = MoviesViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let width = (collectionView.frame.size.width-4) / 2
        let height = width*3/2 + 80
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.setCollectionViewLayout(flowLayout, animated: true)

        // For CollectionView Pagination
        collectionView
            .rx
            .didScroll
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                if self.collectionView.contentOffset.y > (self.collectionView.contentSize.height - self.collectionView.frame.size.height - 100) {
                    self.moviesViewModel.requestData()
                }
            }
            .disposed(by: disposeBag)
    }

}
