//
//  CategoryViewController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class CategoryViewController: UIViewController {
    private let networkController = NetworkController()
    
    private let tableView = UITableView(frame: CGRect.zero)
    private let tableViewCellIdentifier = "CategoryTableViewCell"
    
    private var categories: [Category]? {
        didSet {
            reloadCategories()
        }
    }
    
    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getCategories()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    // MARK: TableView Functions
    
    private func reloadCategories() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: Networking Functions
    
    private func getCategories() {
        networkController.getCategories { (categories, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                self.categories = categories
            }
        }
    }
}


//MARK: TableView Delegate and DataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as UITableViewCell
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
            cell.textLabel?.numberOfLines = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let navigationController = navigationController as? TriviaNavigationController, let category = categories?[indexPath.row] {
            // Assigning category initiates transition to QuestionViewController by TriviaNavigationController
            navigationController.category = category
        }
    }
    
}
