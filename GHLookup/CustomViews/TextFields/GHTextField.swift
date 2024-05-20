//
//  GHTextField.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

class GHTextField: UITextField {

    //MARK: - properties
    
    
    //MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        //storyboard init
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - helpers
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        //IF someone has a really long user name the font will shrink to fit in the textfield
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType =  .no
        returnKeyType = .go 
        
        placeholder = "Enter a username"
    }

}
