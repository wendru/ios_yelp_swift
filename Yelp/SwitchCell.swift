//
//  SwitchCell.swift
//  Yelp
//
//  Created by Andrew Wen on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate: class {
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    weak var delegate: SwitchCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
    }
    
    func setUp() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func setOn(on: Bool) {
        toggle.setOn(on, animated: true)
    }
    
    @IBAction func switchValueChanged(sender: SwitchCell) {
        delegate?.switchCell(self, didChangeValue: toggle.on)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
