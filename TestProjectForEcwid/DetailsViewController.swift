//
//  DetailsViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 16.02.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageClothes: UIImageView!
    @IBOutlet weak var clothesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qantityLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var clothesImage = ""
    var clothesName = ""
    var clothesPrice = ""
    var clothesQantity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageClothes.image = UIImage(named: clothesImage)
        clothesLabel.text = clothesName
        priceLabel.text = clothesPrice
        qantityLabel.text = clothesQantity
        
//        deleteButton.layer.cornerRadius = 15
//        deleteButton.layer.borderWidth = 1
//        deleteButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func deleteClothesAction(_ sender: Any) {
    }
    

}
