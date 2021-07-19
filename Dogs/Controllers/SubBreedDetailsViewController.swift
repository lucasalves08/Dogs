//
//  SubBreedDetailsViewController.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import UIKit

class SubBreedDetailsViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var breed: Breed?
    var dogService: DogServiceProtocol = DogService.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let firstSubBreedName = breed?.subBreeds.first else {
            return
        }
        breedLabel.text = breed?.name
        loadRandomImage(subBreedName: firstSubBreedName)
    }

    private func loadRandomImage(subBreedName: String) {
        guard let breedName = breed?.name else {
            return
        }
        activityIndicator.startAnimating()
        dogService.getRandomImageSubBreed(breed: breedName, subBreed: subBreedName) {  [weak self] dogImageResponse, error in
            guard let dogImage = dogImageResponse,
                  let url = URL(string: dogImage.urlString) else {
                return
            }
            self?.dogService.getImageFile(url: url) { [weak self] imageData, error in
                DispatchQueue.main.sync {
                    self?.activityIndicator.stopAnimating()
                    self?.imageView.image = imageData
                }
            }
        }
    }
}

extension SubBreedDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breed?.subBreeds.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breed?.subBreeds[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let subBreeds = breed?.subBreeds else {
            return
        }
        loadRandomImage(subBreedName: subBreeds[row])
    }
}
