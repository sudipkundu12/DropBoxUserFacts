//
//  CustomFlowLayout.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit

//"heightForPhotoAt" for set image height
// "heightForCaptionAt" set text height
protocol CustomLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

class CustomFlowLayout: UICollectionViewLayout {

    // MARK: Variable
    weak var delegate: CustomLayoutDelegate?
    var numberOfColumns: CGFloat = CGFloat()
    var cellPadding: CGFloat = 5.0
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        guard let customCollectionView = collectionView else {
            fatalError("Failed to collectionView.")
        }
        let insets = customCollectionView.contentInset
        return (customCollectionView.bounds.width - (insets.left + insets.right))
    }
    private var attributesCache = [CustomLayoutAttributes]()

    // MARK: Update Layout
    override func prepare() {
        attributesCache.removeAll()
        guard attributesCache.isEmpty == true || attributesCache.isEmpty == false, let
            collectionView = collectionView else {
                return
        }
        contentHeight = 0
        if attributesCache.isEmpty {
            let columnWidth = contentWidth / numberOfColumns
            var xOffsets = [CGFloat]()
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                // calculate the frame
                let width = columnWidth - cellPadding * 2
                guard let getphotoHeight = (delegate?.collectionView(collectionView: collectionView, heightForPhotoAt: indexPath, with: width)) else {
                    fatalError("Failed to dequeue a getphotoHeight.")
                }
                let photoHeight: CGFloat = getphotoHeight
                guard let getcaptionHeight = (delegate?.collectionView(collectionView: collectionView, heightForCaptionAt: indexPath, with: width)) else {
                    fatalError("Failed to dequeue a getcaptionHeight.")
                }
                let captionHeight: CGFloat = getcaptionHeight
                let height: CGFloat = cellPadding + photoHeight + captionHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                // create layout attributes
                let attributes = CustomLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                attributesCache.append(attributes)
                // update column, yOffset
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                if column >= (Int(numberOfColumns) - 1) {
                    column = 0
                } else {
                    column += 1
                }
            }
        }
        /* ... */
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
        /* ... */
    }
}
// abstract
class CustomLayoutAttributes: UICollectionViewLayoutAttributes {
    var photoHeight: CGFloat = 0.0
    override func copy(with zone: NSZone? = nil) -> Any {
        if let copy = super.copy(with: zone) as? CustomLayoutAttributes {
            copy.photoHeight = photoHeight
            return copy
        }
        return copy
        /* ... */
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
        /* ... */
    }
}
