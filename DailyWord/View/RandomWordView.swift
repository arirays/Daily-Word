
import UIKit

class RandomWordView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "DWBlue")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Random Word"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "DWBlue")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "DWBlue")
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 4
        return label
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle"), for: .normal)
        button.tintColor = .gray
        return button
    }()

        
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        
        backgroundColor = UIColor(named: "DWAlabaster")
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        
        setUpTitleLabel()
        setUpSubtitleLabel()
        setUpDescriptionLabel()
        setUpRefreshButton()
    }

    private func setUpTitleLabel() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            
        ])
       
    }
    
    private func setUpSubtitleLabel() {
        
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
            
        ])
    }
    
    private func setUpDescriptionLabel() {
        
        if descriptionLabel.text == nil {
            descriptionLabel.text = "Tap on the bottom right refresh button \nfor a new word."
        }
        
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        
    }
    
    private func setUpRefreshButton() {
        
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            refreshButton.heightAnchor.constraint(equalToConstant: 20),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
    
    func addTextToLabels(usingWordDetails wordDetails: WordDetails?) {
        
        if let wordDetails = wordDetails {
            subtitleLabel.text = wordDetails.word
            descriptionLabel.text = wordDetails.results?.first?.definition
        } else {
            subtitleLabel.text = ""
            descriptionLabel.text = "Could not find a random word. \nTap on the bottom right refresh button for a new word."
        }
    }
    
    
    
}

