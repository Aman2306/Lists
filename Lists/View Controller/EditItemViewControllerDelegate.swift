//
//  EditItemViewControllerDelegate.swift
//  Lists
//
//  Created by Aman Meena on 27/02/19.
//  Copyright © 2019 Aman Meena. All rights reserved.
//

import Foundation

protocol EditItemViewControllerDelegate {
    func shouldAdd(item: String)
    func isItemPresent(item: String) -> Bool   
}
