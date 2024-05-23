//
//  GHButton.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

class GHButton: UIButton {

   //MARK: - Properties
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        //This init method is called for when UI is initialized by storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    //Custom init method
    init(backgroundColor: UIColor,title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    //MARK: - Helpers
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        //This is how you get dynamic type in iOS
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor,title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

}
