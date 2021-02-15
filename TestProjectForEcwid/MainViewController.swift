//
//  MainViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    let clothes = ["Худи", "Свитшот", "Джоггеры", "Поло", "Рубашка", "Футболка", "Шорты", "Куртка", "Шапка", "Бейсболка", "Жилетка", "Кроссовки", "Ботинки", "Ветровка", "Брюки"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return clothes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = clothes[indexPath.row]
        cell.imageView?.image = UIImage(named: clothes[indexPath.row])

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
