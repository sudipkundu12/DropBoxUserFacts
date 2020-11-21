//
//  FactsListViewModel.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit
import SwiftyJSON

class FactsListViewModel: NSObject {
    // MARK: Variable
    private var webservice: APIClient
    var reloadList = {() -> Void in }
    var titleLbl: String?
    // MARK: UI
    var showLoading: (() -> Void)?
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    ///Array of List Model class
    var rowsDataList: [RowsModel] = [] {
        ///Reload data when data set
        didSet {
            reloadList()
        }
        /* ... */
    }
    /// - parameter webservice: APIClient object from Call API.
    init(webservice: APIClient) {
        self.webservice = webservice
    }
    // MARK: Call Api and store Data On model
    func getAboutListData() {
        self.isLoading = true
        self.webservice.apiGet(serviceName: APIRouter.facts) { (json: JSON?, error: NSError?) in
            self.isLoading = false
            if error != nil {
                return
            }
            guard let jsonResult = json else {
                fatalError("Failed to dequeue a jsonResult.")
            }
            let userData = DataModel.init(object: jsonResult)
            self.titleLbl = userData.title
            self.rowsDataList = userData.rows.filter { !$0.title.isEmpty || !$0.description.isEmpty || !$0.imageHref.isEmpty}
            self.setImageHeight()

          }
        /* ... */
       }
    // MARK: Check For image Size
    func setImageHeight() {
        for index in 0..<self.rowsDataList.count {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                if self.rowsDataList[index].imageHref.isEmpty {
                    self.rowsDataList[index].set_imageHeight(value: 0)
                    return
                }
                guard let imageUrl = URL(string: self.rowsDataList[index].imageHref) else {
                    fatalError("Failed to dequeue a imageUrl.")
                }
                //Calculate image size from url using Alamofire
                self.webservice.getImageSizeFromURL(imageUrl: imageUrl, completionHandler: { (image, error) in
                    if error != nil {
                        self.rowsDataList[index].set_imageHeight(value: 0)
                        return
                    }
                    guard let imageSize = image else {
                        fatalError("Failed to dequeue a imageSize.")
                    }
                      self.rowsDataList[index].set_imageHeight(value: Int(imageSize.size.height))

                })
            }
        }
        /* ... */
    }
}
// MARK: CollectionView CustomLayout Delegate
extension FactsListViewModel: CustomLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return CGFloat(rowsDataList[indexPath.row].imageHeight)
    }
    // MARK: Check for text height
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let post = rowsDataList[indexPath.item]
        let topPadding = CGFloat(8)
        let captionFont = UIFont.systemFont(ofSize: 15)
        let titleFont = UIFont.boldSystemFont(ofSize: 15)
        let captionHeight = self.height(for: post.description, with: captionFont, width: width)
        let titleLblHeight = self.height(for: post.title, with: titleFont, width: width)
        let height = topPadding + captionHeight  + topPadding + titleLblHeight
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