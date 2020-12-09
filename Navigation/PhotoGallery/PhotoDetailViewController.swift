//
//  PhotoDetailViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 11/19/20.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import iOSIntPackage
import SnapKit

class PhotoDetailViewController: UIViewController {
  
//  struct GenericRow<T> {
//    let type: T
//    let title: String
//  }
  
  var filterItems = ColorFilter.allCases
  
  
//  let filtersNames = ["Gaussian Blur", "Motion Blur", "Monochrome", "Posterize", "Color Invert", "Sepia Tone", "Transfer", "Noir", "Tonal", "Process", "Chrome", "Fade", "Crystallize", "Bloom", "Vignette", "No filter"]
  
  private let imageProcessor = ImageProcessor()
  
  private let tableView = UITableView(frame: .zero, style: .grouped)
  
  var leadingAnchor: Constraint? = nil
  
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  var photo: Photo? {
    didSet {
      photoImageView.image = photo?.photo
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    filterItems.append(.bloom(intensity: 0))
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Filter")
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(chooseFilter))
    view.backgroundColor = .darkGray
    setupViews()
    photoImageView.enableZoom()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneEditing))
    photoImageView.addGestureRecognizer(tapGesture)
  }
  
  // MARK: Actions
  @objc func chooseFilter() {
    
    tableView.snp.remakeConstraints { (make) in
      make.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.4)
      leadingAnchor = make.right.equalTo(view.snp_right).constraint
    }
    view.setNeedsLayout()
    
    UIView.animate(withDuration: 0.5) { [self] in
      self.view.layoutIfNeeded()
      tableView.alpha = 0.85
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
    }
  }
  
  @objc func doneEditing() {
    
    tableView.snp.remakeConstraints { (make) in
      make.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.4)
      leadingAnchor = make.left.equalTo(view.snp_right).constraint
    }
    view.setNeedsLayout()
    
    UIView.animate(withDuration: 0.5) { [self] in
      self.view.layoutIfNeeded()
      tableView.alpha = 0
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(chooseFilter))
    }
  }
  
  // MARK: Layout
  func setupViews() {
    
    tableView.alpha = 0
    tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    view.addSubview(photoImageView)
    view.addSubview(tableView)
    
    photoImageView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
      make.width.equalToSuperview()
    }
    tableView.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.4)
      leadingAnchor = make.left.equalTo(view.snp_right).constraint
    }
  }
}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }
  
  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}

extension PhotoDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let title = UILabel()
    title.text = "    Choose Filter"
    title.textColor = UIColor(named: "blueVK")
    title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return title
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
}

extension PhotoDetailViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return filtersNames.count
    return filterItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "Filter", for: indexPath)
//    cell.textLabel?.text = filtersNames[indexPath.row]
    
    if indexPath.row == filterItems.count - 1 {
      cell.textLabel?.text = "No filter"
    } else {
      if let filterName = String(describing: filterItems[indexPath.row]).components(separatedBy: "(").first?.capitalized {
        cell.textLabel?.text = filterName
      }
    }
    cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor(named: "blueVK")
    cell.selectedBackgroundView = backgroundView
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chooseFilterForRow(index: indexPath)
  }
}

extension PhotoDetailViewController {
  
  func chooseFilterForRow(index: IndexPath) {
//    var filter: ColorFilter
//    switch index.row {
//    case 0:
//      filter = ColorFilter.gaussianBlur(radius: 10)
//    case 1:
//      filter = ColorFilter.motionBlur(radius: 10)
//    case 2:
//      filter = ColorFilter.monochrome(color: .gray, intensity: 0.7)
//    case 3:
//      filter = ColorFilter.posterize
//    case 4:
//      filter = ColorFilter.colorInvert
//    case 5:
//      filter = ColorFilter.sepia(intensity: 0.8)
//    case 6:
//      filter = ColorFilter.transfer
//    case 7:
//      filter = ColorFilter.noir
//    case 8:
//      filter = ColorFilter.tonal
//    case 9:
//      filter = ColorFilter.process
//    case 10:
//      filter = ColorFilter.chrome
//    case 11:
//      filter = ColorFilter.fade
//    case 12:
//      filter = ColorFilter.crystallize(radius: 20)
//    case 13:
//      filter = ColorFilter.bloom(intensity: 0.7)
//    case 14:
//      filter = ColorFilter.vignette(intensity: 0.8, radius: 500)
//    default:
//      filter = ColorFilter.gaussianBlur(radius: 0)
//    }
    let filter = filterItems[index.row]
    print(filter)
    if let image = photo?.photo {
      imageProcessor.processImage(sourceImage: image, filter: filter) { (image) in
        photoImageView.image = image
      }
    } else {
      print("No photo found")
    }
  }
}
