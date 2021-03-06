//
//  FactsListViewModel.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit

class FactsListViewModel: NSObject {
    // MARK: Variable
    private var webservice: APIClient
    var reloadList = {() -> Void in }
    var titleLbl: String?
    // MARK: UI
    var showLoading: (() -> Void)?
    var isLoading: Bool = false {
        didSet { showLoading?() }
    }
    ///Array of List Model class
    var rowsDataList: [RowsModel?] = [] {
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
        self.webservice.apiGet(serviceName: APIRouter.facts) { (json: Data?, error: NSError?) in
            self.isLoading = false
            if error != nil {
                return
            }
            guard let jsonResult = json else {
                fatalError(ErrorString.jsonResultError)
            }
            let jsonDecoder = JSONDecoder()
            let userData = try? jsonDecoder.decode(DataModel.self, from: jsonResult)

            self.titleLbl = userData?.title
            self.rowsDataList = userData?.rows?.filter { ($0.title != nil) || ($0.description != nil) || ($0.imageHref != nil)} ?? []
          }
        /* ... */
       }
}
