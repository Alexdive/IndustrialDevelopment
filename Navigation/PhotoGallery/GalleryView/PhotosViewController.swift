//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class PhotosViewController: UIViewController {
  
  weak var coordinator: ProfileNavCoordinator?
  
  // adding view model
  var vm: PhotosViewModel?
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    colView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
    colView.dataSource = self
    colView.delegate = self
    return colView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationItem.title = "Photo Gallery"
  }
  
  // MARK: Layout
  private func setupViews() {
    
    view.addSubview(collectionView)
    collectionView.backgroundColor = vm?.backgroundColor
    
    collectionView.snp.makeConstraints { make in
      make.top.bottom.left.right.equalToSuperview()
    }
  }
}

// MARK: Extensions
extension PhotosViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //  getting info from view model
    return vm?.storage.imageNames.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
    //  getting info from view model
    cell.photo = vm?.storage.imageNames[indexPath.item]
    
    return cell
  }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
  private var baseInset: CGFloat { return 8 }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    coordinator?.openPhotoDetails(index: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = widthForSection(collectionView, numberOfItems: 3, inset: baseInset)
    
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return baseInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return baseInset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: baseInset, left: baseInset, bottom: baseInset, right: baseInset)
  }
  
  private func widthForSection(_ collectionView: UICollectionView, numberOfItems: CGFloat, inset: CGFloat) -> CGFloat {
    return (collectionView.frame.size.width - inset * (numberOfItems + 1)) / numberOfItems
  }
}
