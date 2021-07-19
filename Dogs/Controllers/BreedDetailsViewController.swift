//
//  BreedDetailsViewController.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import UIKit

class BreedDetailsViewController: UIViewController {
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var breed: Breed?
    var dogService: DogServiceProtocol = DogService.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        breedLabel.text = breed?.name
        loadRandomImage()
    }

    private func loadRandomImage() {
        guard let breedName = self.breed?.name else {
            return
        }
        activityIndicator.startAnimating()
        dogService.getRandomImage(breedName: breedName) { [weak self] breedImage, error in
            guard let image = breedImage,
                  let url = URL(string: image.urlString) else {
                return
            }
            self?.dogService.getImageFile(url: url) { [weak self] imageData, error in
                DispatchQueue.main.sync {
                    self?.activityIndicator.stopAnimating()
                    self?.breedImageView.image = imageData
                }
            }
        }
    }
}
