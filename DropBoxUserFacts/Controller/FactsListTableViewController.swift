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
        if Connectivity.isConnectedToInternet {
            self.viewModel.getAboutListData()
        } else {
            AlertView.displayAlert(title: NetworkError.errorTitle.rawValue, message: NetworkError.errorMessage.rawValue)
        }
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        setUpCollection()

    }
    // MARK: CollectionView
    func setUpCollection() {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.heavy(ofSize: 18)]
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
            fatalError(ErrorString.tableViewError)
        }
        cell.post = viewModel.rowsDataList[indexPath.item]
        return cell
    }
}

extension FactsListTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = viewModel.rowsDataList[indexPath.item]
        let padding = ViewPadding.topPadding + ViewPadding.bottomPadding
        let margin = ViewPadding.leftPadding + ViewPadding.rightPadding

        let captionFont =  UIFont.regular(ofSize: 15)
        let titleFont = UIFont.medium(ofSize: 17)
        let captionHeight = self.height(for: post?.description, with: captionFont, width: tableView.frame.size.width - CGFloat(margin))
        let titleLblHeight = self.height(for: post?.title, with: titleFont, width: tableView.frame.size.width - CGFloat(margin))
        let height =  captionHeight + titleLblHeight  + CGFloat(post?.imageHeight ?? 0) + CGFloat(padding) + 4

        return height
    }
    func height(for text: String?, with font: UIFont, width: CGFloat) -> CGFloat {
        if text?.isEmpty == false {
            let nsstring = NSString(string: text ?? "")
            let maxHeight = CGFloat(MAXFLOAT)
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
        if Connectivity.isConnectedToInternet {
            viewModel.getAboutListData()
        } else {
            AlertView.displayAlert(title: NetworkError.errorTitle.rawValue, message: NetworkError.errorMessage.rawValue)
        }
        reloadAboutDataList()
        refreshControl?.endRefreshing()
        self.tableView.contentOffset = .zero
        /* ... */
    }
}
