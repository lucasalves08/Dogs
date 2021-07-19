//
//  DogTableViewControllerTests.swift
//  DogsTests
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import XCTest
@testable import Dogs

class DogTableViewControllerTests: ViewControllerBase {
    var subject: DogTableViewController!

    override func setUp() {
        super.setUp()
        let controller = retrieveController(inStoryboard: "Main", controllerIdentifier: "DogTable")
        guard let viewController = controller as? DogTableViewController else {
            XCTFail("The Dog table view controller should be instantiate")
            return
        }
        subject = viewController
        setup(forViewController: subject)
    }

    func testTitle() {
        XCTAssertEqual(subject.navigationItem.title, "Lista de Cachorros")
    }

    func testTableView() {
        let breeds = [
            Breed(name: "boxer", subBreeds: []),
            Breed(name: "bulldog", subBreeds: ["boston", "english", "french"])
        ]

        subject.breedList = breeds
        subject.viewDidLoad()

        // Verificando se a tabela contém duas células
        XCTAssertEqual(subject.tableView.visibleCells.count, 2)

        let fisrtCell = subject.tableView.visibleCells[0]
        let secondCell = subject.tableView.visibleCells[1]

        // testando se as células são as esperadas
        XCTAssertEqual(fisrtCell.textLabel?.text, "boxer")
        XCTAssertEqual(fisrtCell.accessoryType, UITableViewCell.AccessoryType.none)

        XCTAssertEqual(secondCell.textLabel?.text, "bulldog")
        XCTAssertEqual(secondCell.accessoryType, UITableViewCell.AccessoryType.disclosureIndicator)
    }

}
