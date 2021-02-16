//
//  MainViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit

class MainViewController: UITableViewController {
        
    let clothes = Clothes.getClothes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return clothes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel?.text = clothes[indexPath.row].name
        cell.priceLabel.text = clothes[indexPath.row].price
        cell.quantityLabel.text = clothes[indexPath.row].quantity
        cell.imageClothes?.image = UIImage(named: clothes[indexPath.row].image)
        

        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailsVC = segue.destination as! DetailsViewController
                detailsVC.clothesImage = clothes[indexPath.row].image
                detailsVC.clothesName = clothes[indexPath.row].name
                detailsVC.clothesPrice = clothes[indexPath.row].price
                detailsVC.clothesQantity = clothes[indexPath.row].quantity
            }
        }
    }
    
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        
    }

}
