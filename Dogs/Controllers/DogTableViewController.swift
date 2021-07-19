//
//  DogTableViewController.swift
//  Dogs
//
//  Created by Lucas Alves Dos Santos on 18/07/21.
//

import UIKit

class DogTableViewController: UITableViewController {
    var breedList: [Breed] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBreedList()
    }

    func loadBreedList() {
        DogApi.getBreedsList { breeds, error in
            DispatchQueue.main.sync {
                self.breedList = breeds ?? []
                self.sortBreedByName()
                self.tableView.reloadData()
            }
        }
    }

    func sortBreedByName() {
        breedList.sort {
            $0.name.lowercased() < $1.name.lowercased()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedList.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBreed = breedList[indexPath.row]
        if selectBreed.subBreeds.isEmpty {
            performSegue(withIdentifier: "moveToDetails", sender: selectBreed)
        }
        else {
            performSegue(withIdentifier: "moveToSubBreedDetails", sender: selectBreed)
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if !breedList[indexPath.row].subBreeds.isEmpty {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = breedList[indexPath.row].name
        return cell
    }

    // MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? BreedDetailsViewController {
            detailsViewController.breed = sender as? Breed
        }

        if let subBreedDetailsViewController = segue.destination as? SubBreedDetailsViewController {
            subBreedDetailsViewController.breed = sender as? Breed
        }
    }
}

