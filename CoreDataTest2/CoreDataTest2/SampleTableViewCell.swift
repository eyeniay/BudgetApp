//
//  SampleTableViewCell.swift
//  tableViewDemo
//
//  Created by RajaSoftwareLabs on 01/10/15.
//  Copyright © 2015 jatin. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {

  @IBOutlet weak var invitedSwitch: UISwitch!

    @IBOutlet weak var upid: UIImageView!

    @IBOutlet weak var happysad: UIImageView!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var moneylabel: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var downcategoryLabel: UILabel!
  var delegate: cellModelChanged2!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  override func prepareForReuse() {
    happysad.image = nil
    moneylabel.text=""
    upid.image = nil
    downcategoryLabel.text = ""
    note.text=""
    userimage.image=nil
  }

  @IBAction func switchValueChangel(_ sender: AnyObject) {
    
  }
}
