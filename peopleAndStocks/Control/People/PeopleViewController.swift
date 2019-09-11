//
//  ViewController.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var peopleSearchBar: UISearchBar!
    
    var peopleInfo = [People]() {
        didSet {
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
    }

    var searchedText = "" {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    var filteredPeople: [People] {
        guard searchedText != "" else {
            return peopleInfo
        }
        return peopleInfo.filter {
            $0.name.fullName.lowercased().contains(searchedText.lowercased())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        peopleSearchBar.delegate = self
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PeopleDVC,
        let indexPath = peopleTableView.indexPathForSelectedRow else {return}
        let selectedPerson = filteredPeople[indexPath.row]
        destination.person = selectedPerson
    }
    
    private func loadData() {
        if let pathToData = Bundle.main.path(forResource: "people", ofType: "json") {
            let internalUrl = URL(fileURLWithPath: pathToData)
            do {
                let data = try Data(contentsOf: internalUrl)
                let newPersonFromJSON = try PeopleInfo.getPeople(from: data)
                peopleInfo = newPersonFromJSON.sorted(by: {$0.name.firstName < $1.name.firstName})
            } catch {
                print(error)
            }
        }
    }
}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = filteredPeople[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = person.name.fullName.capitalized
        cell.detailTextLabel?.text = person.location.city.capitalized
        return cell
        
    }
}

extension PeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchText
    }
}
