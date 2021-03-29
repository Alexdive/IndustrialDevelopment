//
//  ViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    
    weak var coordinator: FeedNavCoordinator?
    
    var viewModel: ViewModel?
    
    let post = PostTitle(title: "Some post title")
    
    private var buttonOne: UIButton = {
        let button = UIButton()
        button.setTitle("See Residents", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var buttonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch User Info", for: .normal)
        button.addTarget(self, action: #selector(fetchUser), for: .touchUpInside)
        return button
    }()
    
    private var buttonThree: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch Planet Rotation Period", for: .normal)
        button.addTarget(self, action: #selector(fetchPlanet), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        coordinator?.showPost(post: post)
    }
    
    @objc func fetchUser(_ sender: UIButton) {
        label.text = nil
        activityIndicator.startAnimating()
        viewModel?.fetchAndSerializeData(completion: { title in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.label.text = title
            }
        })
    }
    
    @objc func fetchPlanet(_ sender: UIButton) {
        label.text = nil
        activityIndicator.startAnimating()
        viewModel?.fetchAndDecodePlanetData(urlString: "https://swapi.dev/api/planets/1", completion: { text in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.label.text = text
            }
        })
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemTeal
        title = "Feed"
        
        let stackView = UIStackView(arrangedSubviews: [
            buttonOne,
            buttonTwo,
            buttonThree
        ])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        view.addSubview(stackView)
        view.addSubview(label)
        view.addSubview(activityIndicator)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        activityIndicator.snp.makeConstraints {
            $0.centerY.equalTo(label.snp.centerY)
            $0.centerX.equalToSuperview()
        }
    }
}
