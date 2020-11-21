//
//  FactsListViewController.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit
import SVProgressHUD

class FactsListViewController: UICollectionViewController {
    // MARK: Variable
    var viewModel = FactsListViewModel(webservice: APIClient())
    var refreshControl = UIRefreshControl()

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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        setUpCollection()

    }
    // MARK: CollectionView
    func setUpCollection() {
        collectionView.register(FactsListCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.reuseIdentifire.rawValue)
        collectionView.backgroundColor = UIColor.white
        if let layout = collectionView?.collectionViewLayout as? CustomFlowLayout {
            layout.delegate = viewModel
            layout.numberOfColumns = CGFloat(checkFordeviceSize())
        }
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
                strongSelf.collectionView.reloadData()
            }
        }
        /* ... */
    }
}
// MARK: UICollectionViewDataSource
extension FactsListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.rowsDataList.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.reuseIdentifire.rawValue, for: indexPath) as? FactsListCollectionViewCell else {
            fatalError("Failed to dequeue a ListCollectionViewCell.")
        }
        cell.post = viewModel.rowsDataList[indexPath.item]
        return cell
    }
}
// MARK: Pull to Refresh Collection View
extension FactsListViewController {
    @objc func refresh() {
        viewModel.getAboutListData()
        refreshControl.endRefreshing()
        /* ... */
    }
}
// MARK: Check for Rotation
extension FactsListViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let layout = collectionView?.collectionViewLayout as? CustomFlowLayout {
            layout.numberOfColumns = CGFloat(checkFordeviceSize())
        }
        collectionView.reloadData()
        /* ... */
    }
    func checkFordeviceSize() -> CGFloat {
        var count = 1
        switch self.sizeClass() {
        case (.pad):
            count =  2
        case (.phone):
            count =  1
        case .unspecified: break
        case .tv: break
        case .carPlay: break
        case .mac: break
        @unknown default: break
        }
        return CGFloat(count)
        /* ... */
    }
}
