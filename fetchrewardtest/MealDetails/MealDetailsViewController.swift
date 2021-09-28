//
//  MealDetailsViewController.swift
//  fetchrewardtest
//
//  Created by Alex Rozhin on 9/24/21.
//

import UIKit

class MealDetailsViewController: UIViewController {

    var viewModel:MealDetailsViewModel!

    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.load()
        self.title = viewModel.title()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

extension MealDetailsViewController: BaseViewModelDelegate {

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

extension MealDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsInSection(section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(section);
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = viewModel.cellTypeFor(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier(), for: indexPath)

        switch cellType {
        case .mealImageCell:
            prepareImageCell(cell)
        case .instructionsCell:
            prepareInstructionsCell(cell)
        case .ingredientCell:
            prepareIngredientCell(cell, row:indexPath.row)
        case .watchVideoCell:
            prepareWatchVideoCell(cell)
        }

        return cell
    }

    func prepareImageCell(_ cell:UITableViewCell) {
        if let imageCell = cell as? MealImageCell,
           let imageUrl = viewModel.mealImageUrl() {
            imageCell.setImageUrl(imageUrl)
            imageCell.selectionStyle = .none
        }
    }

    func prepareInstructionsCell(_ cell:UITableViewCell) {
        if let instructionsCell = cell as? InstructionsCell {
            instructionsCell.setInstructionsText(viewModel.mealInstructions())
            instructionsCell.selectionStyle = .none
        }
    }

    func prepareIngredientCell(_ cell:UITableViewCell, row:Int) {
        let (ingredient, measure) = viewModel.mealIngredients()[row]
        cell.textLabel?.text = ingredient
        cell.detailTextLabel?.text = measure
        cell.selectionStyle = .none
    }

    func prepareWatchVideoCell(_ cell:UITableViewCell) {
        cell.textLabel?.text = viewModel.watchVideoText()
        cell.imageView?.image = UIImage(named: "youtube")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selected(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
