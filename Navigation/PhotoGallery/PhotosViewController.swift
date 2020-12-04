//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/18/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    colView.backgroundColor = .white
    colView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
    colView.dataSource = self
    colView.delegate = self
    colView.toAutoLayout()
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
    
    let constraints = [
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}

// MARK: Extensions
extension PhotosViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return PhotosStorage.imageNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
    
    cell.photo = PhotosStorage.imageNames[indexPath.item]
    
    return cell
  }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
  private var baseInset: CGFloat { return 8 }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let photoDetailVC = PhotoDetailViewController()
    photoDetailVC.photo = PhotosStorage.imageNames[indexPath.item]
    navigationController?.pushViewController(photoDetailVC, animated: true)
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
