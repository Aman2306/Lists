//
//  EditItemViewController.swift
//  Lists
//
//  Created by Aman Meena on 27/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    // MARK: - Properties
    
    var editedItem: String?
    var delegate: EditItemViewControllerDelegate!
    
    
    // MARK: - View Init Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        
        // Show the keyboard automatically when the view is about to appear.
        textField.becomeFirstResponder()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: - Custom Methods
    
    fileprivate func setupUI() {
        textField.delegate = self
        
        if editedItem == nil {
            deleteButton.isEnabled = false
        } else {
            textField.text = editedItem
        }
    }
    
    
    
    // MARK: - IBAction Methods
    
    @IBAction func saveItem(_ sender: Any) {
        guard let text = textField.text else { return }
        
        if text != "" {
            if let delegate = delegate {
                if !delegate.isItemPresent(item: text) {
                    
                    if let editedItem = editedItem {
                        // This is the point of interest.
                        // If the editedItem is not nil, then an item is being edited.
                        delegate.shouldReplace(item: editedItem, withItem: text)
                    } else {
                        // Item doesn't exist in the items collection,
                        // so let's add it now.
                        delegate.shouldAdd(item: text)
                    }
                    
                    navigationController?.popViewController(animated: true)
                    
                } else {
                    // Item exists already in the items collection.
                    // Show an alert to indicate that.
                    let alert = UIAlertController(title: "Item exists", message: "\(text) already exists in your shopping list.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        guard let text = textField.text else { return }
        
        if let delegate = delegate {
            delegate.shouldRemove(item: text)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}



// MARK: - UITextFieldDelegate
extension EditItemViewController: UITextFieldDelegate {
    // Pressing enter will return (save)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveItem(self)
        return true
    }
}
