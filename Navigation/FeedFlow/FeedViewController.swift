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
    
    let post = PostTitle(title: "Some post title")
    
    private var buttonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var buttonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch Data", for: .normal)
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        return button
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        coordinator?.showPost(post: post)
    }
    
    @objc func fetchData(_ sender: UIButton) {
        NetworkService.fetchData(urlString: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))") { [weak self] title in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.label.text = title
            }
        }
        
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemTeal
        title = "Feed"
        
        let stackView = UIStackView(arrangedSubviews: [
            buttonOne,
            buttonTwo
        ])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        view.addSubview(stackView)
        view.addSubview(label)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
    }
}
