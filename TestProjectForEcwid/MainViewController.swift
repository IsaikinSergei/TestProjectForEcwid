//
//  MainViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
        
    var clothes: Results<Clothes>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clothes = realm.objects(Clothes.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothes.isEmpty ? 0 : clothes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let clothed = clothes[indexPath.row]

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
        if segue.identifier == "ShowDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailsVC = segue.destination as! DetailsViewController
                
                detailsVC.clothesImage = clothes[indexPath.row].imageData!
                detailsVC.clothesName = clothes[indexPath.row].name
                detailsVC.clothesPrice = clothes[indexPath.row].price!
                detailsVC.clothesQantity = clothes[indexPath.row].quantity!
            }
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newClothesVC = segue.source as? NewClothesViewController else { return }
        newClothesVC.saveNewClothes()
        tableView.reloadData()
        
    }

}
