//
//  NewClothesViewController.swift
//  TestProjectForEcwid
//
//  Created by Sergei Isaikin on 15.02.2021.
//

import UIKit

class NewClothesViewController: UITableViewController {
    
    var currentClothes: Clothes?
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var clothesNameTF: UITextField!
    @IBOutlet weak var priceNameTF: UITextField!
    @IBOutlet weak var quantityNameTF: UITextField!
    @IBOutlet weak var clothesImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        clothesNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditClothes()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    // Создаем метод который сохраняет новые и отредактированные товары
    
    func saveClothes() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = clothesImage.image
        } else {
            image = #imageLiteral(resourceName: "clothes")
        }
        
        let imageData = image?.pngData()
        
        let newClothes = Clothes(name: self.clothesNameTF.text!, price: self.priceNameTF.text, quantity: self.quantityNameTF.text, imageData: imageData)
        
        
        if self.currentClothes != nil {
            try! realm.write {
                self.currentClothes?.name = newClothes.name
                self.currentClothes?.price = newClothes.price
                self.currentClothes?.quantity = newClothes.quantity
                self.currentClothes?.imageData = newClothes.imageData
            }
        } else {
            RealmManager.saveObject(newClothes)
        }
        
    }
    
    // Создаем метод для передачи текущих данных выбранной ячейки для отображения и редактирования в отдельном экране
    
    private func setupEditClothes() {
        if currentClothes != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentClothes?.imageData,
                  let image = UIImage(data: data) else { return }
            
            clothesImage.image = image
            clothesImage.contentMode = .scaleAspectFit
            clothesNameTF.text = currentClothes?.name
            priceNameTF.text = currentClothes?.price
            quantityNameTF.text = currentClothes?.quantity
        }
    }
    
    // Работаем над NavigationBar для редактирования данных выбранной ячейки
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentClothes?.name
        saveButton.isEnabled = true
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}

// MARK: - Text field delegate

extension NewClothesViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию на кнопку Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if clothesNameTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: - Work with image

extension NewClothesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        clothesImage.image = info[.editedImage] as? UIImage
        clothesImage.contentMode = .scaleAspectFill
        clothesImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

