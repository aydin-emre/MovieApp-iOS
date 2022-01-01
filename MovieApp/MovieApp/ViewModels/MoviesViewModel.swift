//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Emre on 31.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

class MoviesViewModel {

    public let sources: PublishSubject<[Movie]> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()

    private var movies = [Movie]()
    private var page = 1
    private var numberOfMovieInOneQuery = 20
    private var isPaginationRequestStillResume = false
    private var isPaginationDone = false

    public func requestData() {
        if isPaginationRequestStillResume || isPaginationDone { return }
        isPaginationRequestStillResume = true

        NetworkManager.shared.movies(page: page) { result in
            switch result {
            case .success(let response):
                if let results = response.results {
                    if self.page == 1 {
                        self.numberOfMovieInOneQuery = results.count
                    }
                    if results.count < self.numberOfMovieInOneQuery {
                        self.isPaginationDone = true
                    }
                    self.isPaginationRequestStillResume = false
                    self.page += 1
                    self.movies += results
                    self.sources.onNext(self.movies)
                } else if let message = response.statusMessage {
                    self.error.onNext(message)
                }
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
            }
        }
    }

}
