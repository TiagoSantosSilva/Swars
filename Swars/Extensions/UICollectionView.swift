//
//  UICollectionViewExtension.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import RxSwift

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could Not Dequeue Cell With Id: \(T.identifier)")
        }
        
        return cell
    }
}

extension UICollectionView {
    var rxNextPageTrigger: Observable<Bool> {
        return self.rx.contentOffset.flatMapLatest { [weak self] (offset) -> Observable<Bool> in
            let shouldTrigger = offset.y + (self?.frame.size.height ?? 0) + 40 > (self?.contentSize.height ?? 0)
            
            return shouldTrigger ? Observable.just(true) : Observable.just(false)
        }
    }
}
