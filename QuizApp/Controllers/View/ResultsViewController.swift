//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Mike Stoltman on 2020-10-02.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var results: [Result] = []
    
    private let tableView = UITableView(frame: CGRect.zero)
    private let cellIdentifier = "ResultsTableViewCell"
    
    private let totalScoreLabel = UILabel(frame: CGRect.zero)
    private let restartButton = UIButton(type: UIButton.ButtonType.roundedRect)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: true)
        setupLabels()
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(totalScoreLabel)
        totalScoreLabel.textAlignment = NSTextAlignment.center
        totalScoreLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        
        totalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        totalScoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        totalScoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        totalScoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 20.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        view.addSubview(restartButton)
        restartButton.setTitle("Restart", for: .normal)
        restartButton.addTarget(self, action: #selector(restartButtonTapped(sender:)), for: .touchUpInside)
        restartButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        restartButton.setTitleColor(UIColor.gray, for: .normal)
        
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10.0).isActive = true
        restartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        restartButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    
    private func setupLabels() {
        var totalPoints: Int = 0
        for result in results {
            totalPoints += result.pointsEarned
        }
        totalScoreLabel.text = "Total Score: \(totalPoints)"
    }
    
}

// MARK: Button Functions
extension ResultsViewController {
    @objc private func restartButtonTapped(sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: TableView Delegate and DataSource
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: cellIdentifier)
        
        if results[indexPath.row].correct {
            cell.textLabel?.text = "Correct"
            cell.textLabel?.textColor = UIColor.green
        }else{
            cell.textLabel?.text = "Incorrect"
            cell.textLabel?.textColor = UIColor.red
        }
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        
        cell.detailTextLabel?.text = "\(results[indexPath.row].pointsEarned) points earned"
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        cell.tintColor = UIColor.gray
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultDetailsViewController") as? ResultDetailsViewController else { return }
        detailsViewController.result = results[indexPath.row]
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
