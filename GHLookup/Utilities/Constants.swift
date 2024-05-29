//
//  Constants.swift
//  GHLookup
//
//  Created by JJ on 22/05/24.
//

import UIKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum Images {
    static let logo = UIImage(named: "gh-logo")
}

enum ScreenSize{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width,ScreenSize.height)
    static let minLength = min(ScreenSize.width,ScreenSize.height)
    
    
}


enum DeviceTypes{
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isIphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isIphone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isIphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isIphone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isIpad = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isIphoneXAspectRatio() -> Bool{
        return isIphoneX || isIphoneXsMaxAndXr
    }
    
}
