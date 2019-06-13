//
//  JWCollectionViewFlowLayout.swift
//  JWCollectionViewFlowLayout
//
//  Created by JW_Macbook on 12/04/2019.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

import UIKit

class JWCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    /// CollectionView Cell row count (horizontal)
    @objc var collectionViewRow:NSInteger = 0
    
    /// CollectionView Cell Column count (Vertical)
    @objc var collectionViewColumn:NSInteger = 0
    
    /// (Optional) CollectionView Page Width
    @objc var collectionViewPageWidth:CGFloat = 0.0
    
    /// (Optional) CollectionView Page Height
    @objc var collectionViewPageHeight:CGFloat = 0.0
    
    /// CollectionView Attatibutes Array
    var attributesArray:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    /// 3. CollectionView 전체 크기 알려주는 정보.
    override var collectionViewContentSize: CGSize {
        
        // (전체갯수/한 페이지 표현정보) * CollectionView Width 정보
        // ex) 2.1 페이지여도 증가 시켜야함. ceil 함수 참조.
        let verticalInfo:Double = Double(attributesArray.count) / Double(collectionViewRow * collectionViewColumn * 1)
        var width:CGFloat = collectionViewPageWidth
        var height:CGFloat = collectionViewPageHeight
        let isPageing:Bool = self.collectionView?.isPagingEnabled ?? false
        
        // 가로방향
        if self.scrollDirection == .horizontal {
            width = CGFloat(ceil(verticalInfo)) * collectionViewPageWidth
            
            // 페이징이 아닐때 간격으로 Size 다시구하기.
            if !isPageing {
                let rowPageCount = ceil(verticalInfo)
                var addValut:CGFloat = 0.0
                for i in 0 ... Int(rowPageCount) {
                    addValut = addValut + CGFloat(i) * self.minimumInteritemSpacing
                }
                width = width + addValut
            }
        }
        
        // 세로방향
        else {
            height = CGFloat(ceil(verticalInfo)) * collectionViewPageHeight
            
            // 페이징이 아닐때 간격으로 Size 다시구하기.
            if !isPageing {
                let columnItmeCount = CGFloat(attributesArray.count)/CGFloat(collectionViewRow)
                height = columnItmeCount * self.itemSize.height + columnItmeCount * self.minimumLineSpacing
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    /// 1. CollectionView Prepare
    /// Cell 위치/크기 등 계산을 사전처리 가능
    override func prepare() {
        super.prepare()
        
        // PageWith 정보 없을시 화면 Size
        if 0.0 == collectionViewPageWidth {
            collectionViewPageWidth = self.collectionView?.frame.width ?? UIScreen.main.bounds.size.width
        }
        
        if 0.0 == collectionViewPageHeight {
            collectionViewPageHeight = self.collectionView?.frame.height ?? UIScreen.main.bounds.size.height
        }
        
        // itemSize 만들어주기.
        // 우선적으로 itemSize를 맞게 구해줍니다.
        // 가로 (Page가로 - (가로간격 * 가로갯수-1))/가로갯수
        let itemSizeWidth:CGFloat = ((self.collectionView?.frame.width)! - (self.minimumInteritemSpacing * CGFloat(collectionViewRow-1)))/CGFloat(collectionViewRow)

        // 세로 (Page세로 - (세로간격 * 세로갯수-1))/세로갯수
        let itemSizeHeight:CGFloat = ((self.collectionView?.frame.height)! - (self.minimumLineSpacing * CGFloat(collectionViewColumn-1)))/CGFloat(collectionViewColumn)
        
        self.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        // 1개의 section 으로 구성된 정보만 고려됨.
        // Attribute 정보 구하기.
        let itemCount:Int = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        if itemCount > 0 {
            for i in 0 ... itemCount-1 {
                let indexPath = IndexPath(item: i, section: 0)
                let attributes = layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
        }
    }
    
    
    /// 2. prepare 에서 꾸민 Attributes Array 정보를 반환한다.
    ///  가장 마지막 전부다 Attributes 꾸미고 나서.
    /// - Parameter rect:
    /// - Returns:
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    /// 2. Cell 속성별 Size 정해주기.
    ///
    /// - Parameter indexPath:
    /// - Returns:
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let index:Int = indexPath.item
        let page:Int = index / (collectionViewRow * collectionViewColumn)
        let isPageing:Bool = self.collectionView?.isPagingEnabled ?? false
        
        // 가로방향일때만 해당되는 데이터 내용.
        if self.scrollDirection == .horizontal {
            // 좌표계산하기.
            // (ex 2*3 칸으로 만들기)
            // 간격 : 가로, 세로 10 씩
            // 1. 가로위치 (row값에따른 위치 선정 0, 1)
            // 2. 아이템 크기 (기본+가로간격)
            // 3. 전체페이지의 위치값 (1페이지당 6개 아이템 씩)
            var x:CGFloat = CGFloat(index % collectionViewRow) *
                (self.itemSize.width + self.minimumInteritemSpacing) +
                CGFloat(page) * collectionViewPageWidth
            
            let y:CGFloat = CGFloat(index / collectionViewRow % collectionViewColumn) *
                (self.itemSize.height + self.minimumLineSpacing)
            
            // 페이징을 하지 않을때 간격정보 추가함.
            if !isPageing {
                x = x + CGFloat(page) * self.minimumInteritemSpacing
            }
            
            // 최종적인 cellRect 정보.
            attribute.frame = CGRect(x: x, y: y, width: self.itemSize.width, height: self.itemSize.height)
        } else {
            let x:CGFloat = CGFloat(index % collectionViewRow) *
                (self.itemSize.width + self.minimumInteritemSpacing)

            
            
            var y:CGFloat = CGFloat(index / collectionViewRow % collectionViewColumn) *
                (self.itemSize.height + self.minimumLineSpacing) +
                CGFloat(page) * collectionViewPageHeight
            
            // 페이징을 하지 않을때 간격정보 추가함.
            if !isPageing {
                y = y + CGFloat(page) * self.minimumLineSpacing
            }
            
            // 최종적인 cellRect 정보.
            attribute.frame = CGRect(x: x, y: y, width: self.itemSize.width, height: self.itemSize.height)
        }
        
        
        return attribute
    }
}
