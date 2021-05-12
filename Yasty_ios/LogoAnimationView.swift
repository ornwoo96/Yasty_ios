//
//  LogoAnimationView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/05/10.
//

import Foundation
import SwiftyGif

class LogoAnimationView: UIView {
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "Logo.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: Int(2.0))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
    }
}
