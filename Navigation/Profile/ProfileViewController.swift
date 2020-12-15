//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 10/31/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
  
  weak var coordinator: ProfileNavCoordinator?
  
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private let headerView = ProfileHeaderView()
  let photosTableView = PhotosTableViewCell()
  
  private var reuseID: String {
    return String(describing: PostTableViewCell.self)
  }
  
  private var photosTableReuseID: String {
    return String(describing: PhotosTableViewCell.self)
  }
  
  // MARK: Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.delegate = self
    
    setupTableView()
    setupLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  // MARK: Layout
  private func setupTableView() {
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseID)
    tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photosTableReuseID)
  }
  
  private func setupLayout() {
    
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(view)
    }
  }
}

// MARK: Exstensions
extension ProfileViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section != 0 else { return 1 }
    return Storage.posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
    
    let post: Post = Storage.posts[indexPath.row]
    cell.configure(post: post)
    
    let photosCell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: photosTableReuseID, for: indexPath) as! PhotosTableViewCell
    
    guard indexPath.section == 0 else { return cell }
    return photosCell
  }
}

extension ProfileViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    guard section == 0 else { return nil }
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .zero
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.section == 0 else { return }
    coordinator?.openPhotoGallery()
  }
}

extension ProfileViewController: ProfileTableViewDelegate {
  
  func didTapAvatarButton() {
    self.tabBarController?.tabBar.isHidden.toggle()
    print("AvatarDelegate")
  }
}
