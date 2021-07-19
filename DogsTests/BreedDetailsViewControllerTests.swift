//
//  BreedDetailsViewControllerTests.swift
//  DogsTests
//
//  Created by Lucas Alves Dos Santos on 19/07/21.
//

import XCTest
@testable import Dogs

class BreedDetailsViewControllerTests: ViewControllerBase {
    var subject: BreedDetailsViewController!

    override func setUp() {
        super.setUp()
        let controller = retrieveController(inStoryboard: "Main", controllerIdentifier: "BreedDetails")
        guard let viewController = controller as? BreedDetailsViewController else {
            XCTFail("The Dog table view controller should be instantiate")
            return
        }
        subject = viewController
        setup(forViewController: subject)
    }

    func testSetupUI() {
        subject.breed = Breed(name: "boxer", subBreeds: [])
        subject.setupUI()
        XCTAssertEqual(subject.breedLabel.text, "boxer")
    }
}
