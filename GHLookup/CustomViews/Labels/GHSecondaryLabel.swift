//
//  GHSecondaryLabel.swift
//  GHLookup
//
//  Created by JJ on 21/05/24.
//

import UIKit

class GHSecondaryLabel: UILabel {

    //MARK: - properties
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat ){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
        
    }
    
    //MARK: - helpers
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }


}
