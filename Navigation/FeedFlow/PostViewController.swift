//
//  PostViewController.swift
//  Navigation
//
//  Created by Alex Permiakov on 12.09.2020.
//  Copyright © 2020 Alex Permiakov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    weak var coordinator: FeedNavCoordinator?
    
    var viewModel: PostViewModel?
    
    var post: PostTitle?
    
    var residents: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let tableViewID = "tableViewID"
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.title
        setupTable()
        setupView()
        fetchData()
    }
    
    func fetchData() {
        activityIndicator.startAnimating()
        viewModel?.fetchAndDecodeResidents(urlString: "https://swapi.dev/api/planets/1",
                                           completion: { arr in
                                            if let arr = arr {
                                                self.residents = arr
                                            }
                                           })
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewID)
    }
    
    private func setupView() {
        view.backgroundColor = .purple
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfo))
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func showInfo() {
        coordinator?.showInfo()
    }
}

extension PostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.text = "    Planet Tatuin residents:"
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

extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: tableViewID, for: indexPath)
        
        let ai = UIActivityIndicatorView()
        cell.addSubview(ai)
        ai.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        ai.startAnimating()
        
        viewModel?.fetchAndGetResidentName(urlString: residents[indexPath.row],
                                           completion: { [weak cell] name in
                                            guard let cell = cell else { return }
                                            DispatchQueue.main.async {
                                                ai.stopAnimating()
                                                cell.textLabel?.text = name
                                            }
                                           })
        return cell
    }
}
