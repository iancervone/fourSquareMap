

import UIKit

class CollectionsVCCollectionCell: UICollectionViewCell {

   lazy var venueImage: UILabel = {
        let image = UILabel()
        image.text = "hi"
    image.font.withSize(40)
        image.backgroundColor = .green
        return image
      }()
      
//      lazy var venueNameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
//        return label
//      }()
//
//      lazy var categoryLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 5
//        label.textAlignment = .center
//        return label
//      }()
      
//      override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setUpCellSubviews()
//        setUpCellConstraints()
//      }
      
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      private func setUpCellSubviews() {
        contentView.addSubview(venueImage)
//        contentView.addSubview(venueNameLabel)
//        contentView.addSubview(categoryLabel)
      }
      
      
      
      // MARK: - CONSTRAINTS

      private func setUpCellConstraints () {
        venueImageConstraints()
//        venueNameLabelConstraints()
//        categoryLabelConstraints()
      }
      
      private func venueImageConstraints() {
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          venueImage.topAnchor.constraint(equalTo: self.topAnchor) ,
          venueImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
          venueImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          venueImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
      }
      
//      private func venueNameLabelConstraints() {
//        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//          venueNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//          venueNameLabel.leadingAnchor.constraint(equalTo:  venuImage.trailingAnchor, constant: 10),
//          venueNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//          venueNameLabel.heightAnchor.constraint(equalToConstant: 40)
//        ])
//      }
//
//      private func categoryLabelConstraints() {
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//          categoryLabel.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 10),
//          categoryLabel.leadingAnchor.constraint(equalTo:  venueNameLabel.leadingAnchor),
//          categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//          categoryLabel.heightAnchor.constraint(equalToConstant: 30)
//        ])
//      }
      
      
      
    }
