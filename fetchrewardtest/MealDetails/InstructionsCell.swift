//
//  InstructionsCell.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/27/21.
//

import UIKit

class InstructionsCell: UITableViewCell {

    @IBOutlet weak var instructionsLabel: UILabel!

    func setInstructionsText(_ text:String) {
        instructionsLabel.text = text
    }
}
