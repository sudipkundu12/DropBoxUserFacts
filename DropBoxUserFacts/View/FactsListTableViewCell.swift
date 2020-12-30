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
        postImageView.contentMode = .scaleAspectFill
        postImageView.layer.cornerRadius = 8.0
        postImageView.clipsToBounds = true
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
        titleLbl.font = UIFont.heavy(ofSize: 17)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    let factsView: UIView = {
        let factsView = UIView()
        factsView.backgroundColor = .white
        factsView.layer.cornerRadius = 8.0
        factsView.clipsToBounds = true
        return factsView
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
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .groupTableViewBackground
        self.selectionStyle = .none
        contentView.backgroundColor = .groupTableViewBackground
    }

    // MARK: - Create UI
    fileprivate func setupViews() {
        
        self.contentView.addSubview(factsView)
        addView(view: factsView)
        
        factsView.addSubview(postImageView)
        addConstraintToPostImage()
        factsView.addSubview(titleLbl)
        addConstraintToTitleLabel()
        factsView.addSubview(descriptionLbl)
        addConstraintToDescriptionLabel()

    }
    func addView(view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    private func addConstraintToTitleLabel() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: titleLbl, attribute: .leading, relatedBy: .equal, toItem: postImageView, attribute: .trailing, multiplier: 1.0, constant: 10)
        
        let trailingConstraint = NSLayoutConstraint(item: titleLbl, attribute: .trailing, relatedBy: .equal, toItem: titleLbl.superview!, attribute: .trailing, multiplier: 1.0, constant: -10)
        
        let topConstraint = NSLayoutConstraint(item: titleLbl, attribute: .top, relatedBy: .equal, toItem: postImageView, attribute: .top, multiplier: 1.0, constant: 0)
        factsView.addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }
    
    private func addConstraintToDescriptionLabel() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .leading, relatedBy: .equal, toItem: titleLbl, attribute: .leading, multiplier: 1.0, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .trailing, relatedBy: .equal, toItem: titleLbl, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .top, relatedBy: .equal, toItem: titleLbl, attribute: .bottom, multiplier: 1.0, constant: 8)
        
        
        let bottomConstraint = NSLayoutConstraint(item: descriptionLbl.superview!, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: descriptionLbl, attribute: .bottom, multiplier: 1.0, constant: 10)
        
        factsView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    private func addConstraintToPostImage() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = NSLayoutConstraint(item: postImageView, attribute: .leading, relatedBy: .equal, toItem: factsView, attribute: .leading, multiplier: 1.0, constant: 10)
        
        let topConstraint = NSLayoutConstraint(item: postImageView, attribute: .top, relatedBy: .equal, toItem: factsView, attribute: .top, multiplier: 1.0, constant: 10)
        
        
        let heightConstraint = NSLayoutConstraint(item: postImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        
        let widthConstraint = NSLayoutConstraint(item: postImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
        
        let bottomConstraint = NSLayoutConstraint(item: postImageView.superview!, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: postImageView, attribute: .bottom, multiplier: 1.0, constant: 10)

        factsView.addConstraints([leadingConstraint, topConstraint, widthConstraint, heightConstraint, bottomConstraint])
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
        } else {
            postImageView.image = #imageLiteral(resourceName: "placeholder")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(ErrorString.initCoderError)
    }

}
