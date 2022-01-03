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
    private let global = DispatchQueue.global(qos: .background)

    func addToFavorites(movie: Movie?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        try? realm.write {
                            realm.add(movie.detached())
                        }
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func removeFromFavorites(movie: Movie?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        if let movieToDelete = realm.objects(Movie.self).filter({ $0.id == movie.id }).first {
                            try? realm.write {
                                realm.delete(movieToDelete)
                            }
                            DispatchQueue.main.async {
                                completion(true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(false)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

    func checkFavorites(movie: Movie?, completion: @escaping (Bool) -> Void = { _ in }) {
        global.sync {
            autoreleasepool {
                do {
                    if let realm = try? Realm(),
                       let movie = movie {
                        let contains = !realm.objects(Movie.self).filter({ $0.id == movie.id }).isEmpty
                        DispatchQueue.main.async {
                            completion(contains)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            }
        }
    }

}
