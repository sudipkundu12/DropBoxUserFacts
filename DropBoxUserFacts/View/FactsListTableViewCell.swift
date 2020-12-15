//
//  FactsListTableViewCell.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 04/12/20.
//

import UIKit

class FactsListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.contentMode = .scaleAspectFit
        return postImageView
    }()
    let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.font = UIFont.regular(ofSize: 15)
        descriptionLbl.numberOfLines = 0
        return descriptionLbl
    }()
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.medium(ofSize: 17)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    lazy var stackView: UIStackView! = {
            let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 2.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        }()
    // MARK: - Variable
    var post: RowsModel? {
        didSet {
            self.updateUI()
        }
        /* ... */
    }
    // MARK: - Frame
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupViews()

    }
    // MARK: - Create UI
    fileprivate func setupViews() {
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(descriptionLbl)
        stackView.addArrangedSubview(postImageView)
        contentView.addSubview(stackView)

        stackView.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, right: self.safeRightAnchor, bottom: self.safeBottomAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, paddingBottom: -8)
    }
    // MARK: - Update UI
    func updateUI() {
        guard let aboutData = post else {
            fatalError(ErrorString.rowsModelError)
        }
        descriptionLbl.text = aboutData.description
        titleLbl.text = aboutData.title
        if aboutData.imageHref?.isEmpty == false {
            guard let imageUrl = URL.init(string: aboutData.imageHref! ) else {
                fatalError(ErrorString.imageUrlError)
            }
            postImageView.af.setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), filter: nil)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(ErrorString.initCoderError)
    }

}
