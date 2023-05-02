//
//  DynamicSizeFitImageView.swift
//  
//
//  Created by Vladyslav Skintiian on 02.05.2023.
//

import UIKit

final class DynamicSizeFitImageView: UIImageView {
    private var aspectRatioConstraint:NSLayoutConstraint? = nil

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }

    public override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }

    public override init(image: UIImage!) {
        super.init(image:image)
        setup()
    }

    public override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }

    override public var image: UIImage? {
        didSet {
            updateAspectRatioConstraint()
        }
    }

    private func setup() {
        contentMode = .scaleAspectFit
        updateAspectRatioConstraint()
    }

    private func updateAspectRatioConstraint() {
        if let aspectRatioConstraint {
            removeConstraint(aspectRatioConstraint)
        }

        aspectRatioConstraint = nil

        guard let imageSize = image?.size, imageSize.height != 0 else { return }
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: imageSize.width / imageSize.height,
            constant: 0
        )
        self.addConstraint(constraint)
        self.aspectRatioConstraint = constraint
    }
}
