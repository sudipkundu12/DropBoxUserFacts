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
        // Init view model
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        viewModel.getAboutListData()
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        setUpCollection()

    }
    // MARK: CollectionView
    func setUpCollection() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 18)!]
        tableView.register(FactsListTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier.reuseIdentifire.rawValue)
        tableView.backgroundColor = .white
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
            fatalError("Failed to dequeue a FactsListTableViewCell.")
        }
        cell.post = viewModel.rowsDataList[indexPath.item]
        return cell
    }
  


}
extension FactsListTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = viewModel.rowsDataList[indexPath.item]
        let padding = CGFloat(16)
        let margin = CGFloat(16 * 2)

        let captionFont =  UIFont(name: "Avenir", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let titleFont = UIFont(name: "Avenir-Medium", size: 17) ?? UIFont.boldSystemFont(ofSize: 15)
        let captionHeight = self.height(for: post.description, with: captionFont, width: tableView.frame.size.width - margin)
        let titleLblHeight = self.height(for: post.title, with: titleFont, width: tableView.frame.size.width - margin)
        let height =  captionHeight + titleLblHeight + CGFloat(post.imageHeight) + padding + 4

        return height
    }
    func height(for text: String, with font: UIFont, width: CGFloat) -> CGFloat {
        if text.isEmpty == false {
            let nsstring = NSString(string: text)
            let maxHeight = CGFloat(10064.0)
            let textAttributes = [NSAttributedString.Key.font: font]
            let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
            return ceil(boundingRect.height)
        } else {
            return 0

        }
    }
}
extension FactsListTableViewController {
    @objc func refresh() {
        viewModel.getAboutListData()
        refreshControl?.endRefreshing()
        /* ... */
    }
}