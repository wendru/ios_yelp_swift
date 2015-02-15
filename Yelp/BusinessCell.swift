//
//  BusinessCell.swift
//  Yelp
//
//  Created by Andrew Wen on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewsCount: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categories: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateFields(business: Business) {
        name.text = business.name
//        name.numberOfLines = 0
//        name.sizeToFit()
        
        reviewsCount.text = NSString(format: "%d Reviews", business.numReviews)
        
        address.text = business.address
        
        categories.text = business.categories
        
        picture.setImageWithURL(NSURL(string: business.imageUrl))
        picture.layer.cornerRadius = 4
        picture.clipsToBounds = true
        
        ratingImage.setImageWithURL(NSURL(string: business.ratingImageUrl))
    }

}
