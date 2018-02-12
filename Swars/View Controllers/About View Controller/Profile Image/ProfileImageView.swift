//
//  ProfileImageView.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView, Roundable {

    override func awakeFromNib() {
        super.awakeFromNib()
        rounded(with: self.frame.height/2)
        self.clipsToBounds = true
    }
}
