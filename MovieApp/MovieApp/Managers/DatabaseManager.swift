//
//  DatabaseManager.swift
//  MovieApp
//
//  Created by Emre on 2.01.2022.
//

import Foundation
import RealmSwift

public class DatabaseManager {

    // MARK: - Shared Manager

    static var shared = DatabaseManager()

    func addToFavorites(movie: Movie?) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        try? realm.write {
                            realm.add(movie)
                        }
                    }
                }
            }
        }
    }

    func removeFromFavorites(movie: Movie?) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        let objects = realm.objects(Movie.self)
                        if objects.isInvalidated { return }
                        if let movieToDelete = objects.filter({ $0.id == movie.id }).first {
                            try? realm.write {
                                realm.delete(movieToDelete)
                            }
                        }
                    }
                }
            }
        }
    }

    func checkFavorites(movie: Movie?, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        let objects = realm.objects(Movie.self)
                        if objects.isInvalidated { return }
                        let isFavorite = !objects.filter({ $0.id == movie.id }).isEmpty
                        DispatchQueue.main.async {
                            completion(isFavorite)
                        }
                    }
                }
            }
        }
    }

}
