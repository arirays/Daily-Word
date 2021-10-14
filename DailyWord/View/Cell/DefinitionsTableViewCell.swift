

import UIKit

class DefinitionsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(named: "DWBlue")
        label.numberOfLines = 5
        return label
    }()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    
    private func setUpUI() {
        
        backgroundColor = .clear
        setUpLabel()
    }
    
    private func setUpLabel() {
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8)
        ])
    }
    
    func loadWordDetail(_ wordResult: WordResult) {
        
        label.text = wordResult.definition
    }
}
