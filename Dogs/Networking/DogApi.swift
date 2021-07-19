//
//  DogApi.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import Foundation
import UIKit

class DogApi {
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
    class func getBreedsList(completionHandler: @escaping([Breed]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
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
    class func getRandomImage(breedName: String, completionHandler: @escaping (DogImageResponse?, Error?) -> Void){
        let randomImageEndPoint = DogApi.Endpoint.randomImageForBreed(breedName).url
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) {
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
    class func getRandomImageSubBreed(breed: String,subBreed:String, completionHandler: @escaping (DogImageResponse?,Error?) -> Void){
        let randomImageEndPoint = DogApi.Endpoint.randomImageForSuBreed(breed, subBreed).url
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) {
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

    class func getImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
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
