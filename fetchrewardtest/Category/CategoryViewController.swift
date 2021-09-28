//
//  CategoryViewController.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import UIKit

class CategoryViewController: UIViewController {

    var viewModel:CategoryViewModel!

    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.load()
        self.title = viewModel.title()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }

}

extension CategoryViewController: BaseViewModelDelegate {

    func dataUpdated() {
        self.title = viewModel.title()
        self.tableView.reloadData()
    }

    func presentAlert(_ text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
            if let self = self {
                self.viewModel.alertCancel()
            }
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] action in
            if let self = self {
                self.viewModel.alertRetry()
            }
        }))
        self.present(alert, animated: true)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMeals()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        cell.setMeal(name: viewModel.mealName(indexPath),
                     thumbnail: viewModel.mealThumbnail(indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selected(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
