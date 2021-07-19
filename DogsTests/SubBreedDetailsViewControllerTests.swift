//
//  SubBreedDetailsViewControllerTests.swift
//  DogsTests
//
//  Created by Lucas Alves Dos Santos on 19/07/21.
//

import XCTest
@testable import Dogs

class SubBreedDetailsViewControllerTests: ViewControllerBase {
    var subject: SubBreedDetailsViewController!

    override func setUp() {
        super.setUp()
        let controller = retrieveController(inStoryboard: "Main", controllerIdentifier: "SubBreedDetails")
        guard let viewController = controller as? SubBreedDetailsViewController else {
            XCTFail("The Dog table view controller should be instantiate")
            return
        }
        subject = viewController
        setup(forViewController: subject)
    }

    func testSetupUI() {
        let breed = Breed(name: "bulldog", subBreeds: ["boston", "english", "french"])
        subject.breed = breed
        subject.setupUI()
        XCTAssertEqual(subject.breedLabel.text, "bulldog")
    }

    func testPickerView() {
        let breed = Breed(name: "bulldog", subBreeds: ["boston", "english", "french"])
        subject.breed = breed
        subject.viewDidLoad()
        
        let numberOfComponent = subject.pickerView.numberOfComponents
        XCTAssertEqual(numberOfComponent, 1)
        let numberOfRows = subject.pickerView(subject.pickerView, numberOfRowsInComponent: numberOfComponent)
        XCTAssertEqual(numberOfRows, 3)

        for row in 0..<numberOfRows {
            let title = subject.pickerView(subject.pickerView, titleForRow: row, forComponent: numberOfComponent)
            print(breed.subBreeds[row])
            XCTAssertEqual(title, breed.subBreeds[row])
        }
    }
}
