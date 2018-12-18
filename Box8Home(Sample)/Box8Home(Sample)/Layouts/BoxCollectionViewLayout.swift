//
//  BoxCollectionViewLayout.swift
//  Box8Home(Sample)
//
//  Created by tibin thomas on 05/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

///no longer used
protocol BoxLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class BoxCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: BoxLayoutDelegate!
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    

}


/// used for cell layout in HomeView Controller collection view
public protocol ContentDynamicLayoutDelegate: class {
    func cellSize(indexPath: IndexPath) -> CGSize
}

public enum DynamicContentAlign {
    case left
    case right
}

public struct ItemsPadding {
    public let horizontal: CGFloat
    public let vertical: CGFloat
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    static var zero: ItemsPadding {
        return ItemsPadding()
    }
}

public class ContentDynamicLayout: UICollectionViewFlowLayout {
    public private(set) var cachedLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    public var contentAlign: DynamicContentAlign = .left
    public var contentPadding: ItemsPadding = .zero
    public var cellsPadding: ItemsPadding = .zero
    public var contentSize: CGSize = .zero
    public weak var delegate: ContentDynamicLayoutDelegate?
    
    override public func prepare() {
        super.prepare()
        
        cachedLayoutAttributes.removeAll()
        calculateCollectionViewCellsFrames()
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cachedLayoutAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedLayoutAttributes.first { attributes -> Bool in
            return attributes.indexPath == indexPath
        }
    }
    
    public func calculateCollectionViewCellsFrames() {
        fatalError("Method must be overriden")
    }
    
    func addCachedLayoutAttributes(attributes: UICollectionViewLayoutAttributes) {
        cachedLayoutAttributes.append(attributes)
    }
    
    override public var collectionViewContentSize: CGSize {
        return contentSize
    }
}
public class FlickrStyleFlowLayout: ContentDynamicLayout {
    private let kCellsInSection: Int = 4
    private let kRowsCount: Int = 5
    private let kColumnsCount: Int = 2
    
    override public func calculateCollectionViewCellsFrames() {
        guard let contentCollectionView = collectionView, delegate != nil else {
            return
        }
        
        contentSize.width = contentCollectionView.frame.size.width
        
        var yOffset: CGFloat = contentPadding.vertical
        
        let sectionsCount = collectionView!.numberOfSections
        
        for section in 0..<sectionsCount {
            
            let itemsCount = contentCollectionView.numberOfItems(inSection: section)
            
            for item in 0 ..< itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let smallCellHeight: CGFloat = (contentCollectionView.frame.height - 2 * contentPadding.vertical - cellsPadding.vertical) / CGFloat(kRowsCount)
                let largeCellHeight: CGFloat = smallCellHeight * 2 + cellsPadding.vertical
                var cellWidth = (contentCollectionView.frame.width - 2 * contentPadding.horizontal - cellsPadding.horizontal) / 2
                //to support full width header in collection view
                if section == 0{
                     cellWidth = (contentCollectionView.frame.width - 2 * contentPadding.horizontal )
                }
                var addCellHeight = (contentCollectionView.frame.height - 2 * contentPadding.vertical - cellsPadding.vertical) / CGFloat(kRowsCount - 1)
                //to support variable  height header in collection view
                if section == 0{
                addCellHeight = (contentCollectionView.frame.height - 2 * contentPadding.vertical - cellsPadding.vertical) / 2.5
                }
                let addCellWidth = contentCollectionView.frame.width - 2 * contentPadding.horizontal
                
                //to support variable  height header in collection view
                if indexPath.section == 0{
                    attributes.frame = CGRect(x: contentPadding.horizontal, y: yOffset, width: cellWidth, height: addCellHeight)
                    yOffset += addCellHeight + cellsPadding.vertical
                }
                else{
                if indexPath.row % kCellsInSection == 0 {
                    attributes.frame = CGRect(x: contentPadding.horizontal, y: yOffset, width: cellWidth, height: smallCellHeight)
                    yOffset = (indexPath.row + 1 == itemsCount) ? yOffset + smallCellHeight : yOffset
                    yOffset += cellsPadding.vertical
                } else if indexPath.row % kCellsInSection == 1 {
                    yOffset -= cellsPadding.vertical
                    attributes.frame = CGRect(x: cellWidth + contentPadding.horizontal + cellsPadding.horizontal, y: yOffset, width: cellWidth, height: largeCellHeight)
                    yOffset = (indexPath.row + 1 == itemsCount) ? yOffset + largeCellHeight : yOffset + smallCellHeight
                    yOffset += cellsPadding.vertical
                } else if indexPath.row % kCellsInSection == 2 {
                    attributes.frame = CGRect(x: contentPadding.horizontal, y: yOffset, width: cellWidth, height: smallCellHeight)
                    yOffset += smallCellHeight + cellsPadding.vertical
                } else if indexPath.row % kCellsInSection == 3 {
                    attributes.frame = CGRect(x: contentPadding.horizontal, y: yOffset, width: addCellWidth, height: addCellHeight)
                    yOffset += addCellHeight + cellsPadding.vertical
                }
                }
                addCachedLayoutAttributes(attributes: attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
