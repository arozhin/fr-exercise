//
//  CategoryListViewController.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import UIKit

class CategoryListViewController: UIViewController {
    
    var viewModel:CategoryListViewModel!
    
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // instantiate router and vm for the root vc here
        let router = CategoryListRouter(withViewController: self)
        viewModel = CategoryListViewModel(withRouter: router)
        setupTableView()
        reload()
        self.title = viewModel.title()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
    }

    @objc func reload() {
        self.tableView.refreshControl?.beginRefreshing()
        viewModel.load()
    }

}

extension CategoryListViewController: BaseViewModelDelegate {

    func dataUpdated() {
        self.title = viewModel.title()
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }

    func presentAlert(_ text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self] action in
            if let self = self {
                self.viewModel.alertRetry()
            }
        }))
        self.present(alert, animated: true)
        self.tableView.refreshControl?.endRefreshing()
    }
}

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.setCategory(name: viewModel.categoryName(indexPath),
                         description: viewModel.categoryDescription(indexPath),
                         thumbnail: viewModel.categoryThumbnail(indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selected(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
