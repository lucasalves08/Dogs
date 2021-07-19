//
//  DogService.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import Foundation
import UIKit

class DogService: DogServiceProtocol {
    static let sharedInstance = DogService()
    var urlSession = URLSession.shared

    enum Endpoint {
        case listAllBreeds
        case randomImageForBreed(String)
        case randomImageForSuBreed(String, String)

        var url: URL {
            return URL(string: self.stringValue)!
        }

        var stringValue: String {
            switch self {
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .randomImageForSuBreed(let breed, let subBreed):
                return "https://dog.ceo/api/breed/\(breed)/\(subBreed)/images/random"
            }
        }
    }

    //MARK: - Pega as racas
    func getBreedsList(completionHandler: @escaping([Breed]?, Error?) -> Void) {
        let task = urlSession.dataTask(with: Endpoint.listAllBreeds.url) {
            (data, reponse, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let breedsReponse = try! decoder.decode(BreedListResponse.self, from: data)
            let breeds = breedsReponse.breeds.map ({ response -> Breed in
                return Breed(name: response.key, subBreeds: response.value)
            })
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    //MARK: - Pega as fotos aleatorias de uma raca
    func getRandomImage(breedName: String, completionHandler: @escaping (DogImageResponse?, Error?) -> Void) {
        let randomImageEndPoint = Endpoint.randomImageForBreed(breedName).url
        let task = urlSession.dataTask(with: randomImageEndPoint) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImageResponse.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }

    //MARK: - Pega as fotos aleatorias de uma subraca
    func getRandomImageSubBreed(breed: String,subBreed:String, completionHandler: @escaping (DogImageResponse?,Error?) -> Void) {
        let randomImageEndPoint = Endpoint.randomImageForSuBreed(breed, subBreed).url
        let task = urlSession.dataTask(with: randomImageEndPoint) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImageResponse.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }

    func getImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = urlSession.dataTask(with: url, completionHandler: { (data, _, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
}

protocol DogServiceProtocol {
    func getBreedsList(completionHandler: @escaping([Breed]?, Error?) -> Void)
    func getRandomImage(breedName: String, completionHandler: @escaping (DogImageResponse?, Error?) -> Void)
    func getRandomImageSubBreed(breed: String,subBreed:String, completionHandler: @escaping (DogImageResponse?,Error?) -> Void)
    func getImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void)
}
