//
//  GHBodyLabel.swift
//  GHLookup
//
//  Created by JJ on 11/05/24.
//

import UIKit

class GHBodyLabel: UILabel {

    //MARK: - properties
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment ){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
        
    }
    
    //MARK: - helpers
    private func configure(){
        textColor = .secondaryLabel
        //Dynamic type apple font
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
