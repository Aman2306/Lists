//
//  RenameListView.swift
//  Lists
//
//  Created by Aman Meena on 27/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import UIKit

class RenameListView: UIView {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Properties
    
    var cancelHandler: (() -> Void)?
    var renameHandler: ((_ name: String) -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        loadContent()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    // MARK: - Custom Methods

    func handleRenaming(handler: @escaping (_ name: String) -> Void) {
        renameHandler = handler
    }
    
    func handleCancelRenaming(handler: @escaping () -> Void) {
        cancelHandler = handler
    }
    
    fileprivate func loadContent() {
        if let nibContents = Bundle.main.loadNibNamed("RenameListView", owner: self, options: nil) {
            if let view = nibContents[0] as? UIView {
                self.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        }
    }
    
    
    
    
    
    // MARK: - IBAction Methods

    @IBAction func rename(_ sender: Any) {
        guard let text = textField.text else { return }
        if text != "" {
            if let handler = renameHandler {
                handler(text)
            }
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        if let handler = cancelHandler {
            handler()
        }
    }
    
}

