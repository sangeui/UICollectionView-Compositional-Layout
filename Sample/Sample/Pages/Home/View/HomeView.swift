//
//  HomeView.swift
//  Sample
//
//  Created by William on 2023/01/24.
//

import Combine
import UIKit

class HomeView: UIView {
    var userDidSelectRowAtCategory: PassthroughSubject<Category, Never> = .init()
    
    private let labelView: UILabelView = .init()
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    private let categories: [Category] = [.grid_layout]
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < categories.count else {
            return
        }
        
        self.userDidSelectRowAtCategory.send(self.categories[indexPath.row])
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let component = self.categories[indexPath.row]
        
        var configuration = cell.defaultContentConfiguration()
        configuration.textProperties.font = .systemFont(ofSize: 13, weight: .semibold)
        configuration.text = component.title
        configuration.image = .init(systemName: component.iconImageSystemName)
        
        cell.contentConfiguration = configuration
        cell.selectionStyle = .none
        
        return cell
    }
}

private extension HomeView {
    func setup() {
        self.backgroundColor = .systemGroupedBackground
        self.setupLabelView(view: self.labelView)
        self.setupTableView(tableView: self.tableView)
    }
    
    func setupTableView(tableView: UITableView) {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: .zero).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: .zero).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupLabelView(view: UILabelView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBackground
        
        view.label.textAlignment = .left
        view.label.font = .systemFont(ofSize: 15, weight: .bold)
        view.label.updateInsets(.init(top: 20, left: 20, bottom: 20, right: 20))
        view.label.text = "UICollectionView Compositional Layout"
    }
}
