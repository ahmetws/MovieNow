//
//  MovieCell.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

class MovieCell: UITableViewCell {

    private enum Constant {
        static let padding: CGFloat = 16
        static let imageSize: CGSize = CGSize(width: 60, height: 90)
    }

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return titleLabel
    }()

    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 4
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        return subtitleLabel
    }()

    private lazy var _imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.imageSize.width / 4
        imageView.layer.cornerCurve = .continuous
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .systemGray6

        [titleLabel, subtitleLabel, _imageView].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            _imageView.widthAnchor.constraint(equalToConstant: Constant.imageSize.width),
            _imageView.heightAnchor.constraint(equalToConstant: Constant.imageSize.height),
            _imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.padding),
            _imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.padding),
            titleLabel.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: Constant.padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.padding),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -Constant.padding / 2),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.padding)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        _imageView.image = nil
    }

    public func setup(with movie: Movie) {
        titleLabel.text = movie.title
        subtitleLabel.text = movie.overview
        _imageView.setImage(with: movie.posterURL)
        selectionStyle = .none
    }
}
