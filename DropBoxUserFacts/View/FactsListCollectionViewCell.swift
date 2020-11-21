//
//  FactsListCollectionViewCell.swift
//  DropBoxUserFacts
//
//  Created by sudip kundu on 20/11/20.
//

import UIKit

class FactsListCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.layer.cornerRadius = 5
        postImageView.contentMode = .scaleAspectFit
        return postImageView
    }()
    let descriptionLbl: UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.font = UIFont.systemFont(ofSize: 15)
        descriptionLbl.numberOfLines = 0
        return descriptionLbl
    }()
    let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    // MARK: - Variable
    var post: RowsModel? {
        didSet {
            setupViews()
            self.updateUI()
        }
        /* ... */
    }
    // MARK: - Frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - Create UI
    fileprivate func setupViews() {
        contentView.addSubview(postImageView)
        let stackView = UIStackView(arrangedSubviews: [postImageView,
                                                       titleLbl,
                                                       descriptionLbl])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        stackView.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, right: self.safeRightAnchor, bottom: self.safeBottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBottom: -5)
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.borderWidth = 1.0
        /* ... */

    }
    // MARK: - Update UI
    func updateUI() {
        guard let aboutData = post else {
            fatalError("Failed to dequeue a RowsModel.")
        }
        descriptionLbl.text = aboutData.description
        titleLbl.text = aboutData.title
        if aboutData.imageHref.isEmpty == false {
            guard let imageUrl = URL.init(string: aboutData.imageHref ) else {
                fatalError("Failed to dequeue a imageHref.")
            }
            postImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "placeholder"), filter: nil)
        }
        postImageView.layer.cornerRadius = 5.0
        postImageView.layer.masksToBounds = true
        self.setNeedsUpdateConstraints()
        self.layoutIfNeeded()
        /* ... */

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
