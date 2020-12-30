//
//  FactsListTableViewController.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 04/12/20.
//

import UIKit
import SVProgressHUD

class FactsListTableViewController: UITableViewController {
    // MARK: Variable
    private var viewModel = FactsListViewModel(webservice: APIClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        if Connectivity.isConnectedToInternet {
            self.viewModel.getAboutListData()
        } else {
            AlertView.displayAlert(title: NetworkError.errorTitle.rawValue, message: NetworkError.errorMessage.rawValue)
        }
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        setUpTableView()

    }
    // MARK: TableView
    func setUpTableView() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.heavy(ofSize: 18)]
        tableView.register(FactsListTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.reuseIdentifire.rawValue)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        reloadAboutDataList()
        /* ... */
    }

    func reloadAboutDataList() {
        viewModel.reloadList = { [weak self] ()  in
            ///UI Changes in main tread
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                if let titletext = strongSelf.viewModel.titleLbl {
                    strongSelf.title = titletext
                }
                strongSelf.tableView.reloadData()
            }
        }
        /* ... */
    }
}

// MARK: - Table view data source
extension FactsListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsDataList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.reuseIdentifire.rawValue, for: indexPath) as? FactsListTableViewCell else {
            fatalError(ErrorString.tableViewError)
        }
        cell.post = viewModel.rowsDataList[indexPath.item]

        return cell
    }
}
extension FactsListTableViewController {
    @objc func refresh() {
        if Connectivity.isConnectedToInternet {
            viewModel.getAboutListData()
        } else {
            self.viewModel.rowsDataList = []
            self.viewModel.titleLbl = nil
            self.title = nil
            AlertView.displayAlert(title: NetworkError.errorTitle.rawValue, message: NetworkError.errorMessage.rawValue)
        }
        tableView.refreshControl?.endRefreshing()
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.contentOffset = CGPoint.zero
        })
        reloadAboutDataList()
        /* ... */
    }
}
