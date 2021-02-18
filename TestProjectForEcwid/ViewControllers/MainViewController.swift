//
//  MainViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var clothes: Results<Clothes>!
    private var filteredClothes: Results<Clothes>!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clothes = realm.objects(Clothes.self)
        
        // Setup the SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredClothes.count
        }
        return clothes.isEmpty ? 0 : clothes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        var clothed = Clothes()
        if isFiltering {
            clothed = filteredClothes[indexPath.row]
        } else {
            clothed = clothes[indexPath.row]
        }
        
        cell.nameLabel.text = clothed.name
        cell.priceLabel.text = clothed.price
        cell.quantityLabel.text = clothed.quantity
        cell.imageClothes.image = UIImage(data: clothed.imageData!)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = clothes[indexPath.row]
            RealmManager.deleteObject(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let item: Clothes
            if isFiltering {
                item = filteredClothes[indexPath.row]
            } else {
                item = clothes[indexPath.row]
            }
            let newClothesVC = segue.destination as! NewClothesViewController
            
            newClothesVC.currentClothes = item
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newClothesVC = segue.source as? NewClothesViewController else { return }
        
        // Создаем отдельный поток для сохранения нового или отредактированного товара в БД с задержкой на 3 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            newClothesVC.saveClothes()
            self.tableView.reloadData()
        })
        
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentText(searchController.searchBar.text!)
    }
    // Создаем метод для фильтрации содержимого ячеек по имени и цене товара
    private func filterContentText(_ text: String) {
        filteredClothes = clothes.filter("name CONTAINS[c] %@ OR price CONTAINS[c] %@", text, text)
        tableView.reloadData()
    }
}
