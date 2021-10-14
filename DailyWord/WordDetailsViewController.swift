//
//  WordDetailsViewController.swift
//  DailyWord
//
//  Created by Ari on 9/7/21.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DWRed")
        return view
    }()
    
    lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor(named: "DWBlue")
        label.text = word.uppercased()
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    
    let definitionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let definitionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Definition"
        label.textColor = UIColor(named: "DWBlue")
        return label
    }()
    
    let synonymsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    let synonymsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Synonyms"
        label.textColor = UIColor(named: "DWBlue")
        return label
    }()
    
    let antonymsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    let antonymsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Antonyms"
        label.textColor = UIColor(named: "DWBlue")
        return label
    }()
    
    let examplesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    let examplesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Examples"
        label.textColor = UIColor(named: "DWBlue")
        return label
    }()
    
    
    
    let word: String
    let wordResult: WordResult
    
    init(word: String, wordResult: WordResult) {
        self.word = word
        self.wordResult = wordResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        setUpHeader()
        setUpStackViewContainer()
        setUpDefinitionStackView()
        setUpSynonymStackView()
        setUpAntonymStackView()
        setUpExamplesStackView()
        
        
        
        
        addEmptyView()
    }
    
    
    private func setUpHeader() {
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        headerView.addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
        
    }
    
    private func setUpStackViewContainer() {
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpDefinitionStackView() {
        
        definitionStackView.distribution = .fill
        definitionStackView.addArrangedSubview(definitionTitleLabel)
        
        NSLayoutConstraint.activate([
            definitionTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let definitionDescriptionLabel = UILabel()
        definitionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        definitionDescriptionLabel.text = wordResult.definition
        definitionDescriptionLabel.numberOfLines = 0
        definitionDescriptionLabel.lineBreakMode = .byWordWrapping
        definitionDescriptionLabel.textColor = UIColor(named: "DWBlue")
        
        definitionStackView.addArrangedSubview(definitionDescriptionLabel)
        
        stackView.addArrangedSubview(definitionStackView)
    }
    
    
    private func setUpSynonymStackView() {
        
        guard let synonyms = wordResult.synonyms, !synonyms.isEmpty else {
            return
        }
    
        synonymsStackView.addArrangedSubview(synonymsTitleLabel)
        
        NSLayoutConstraint.activate([
            synonymsTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for synonym in synonyms {
            
            let synonymLabel = UILabel()
            synonymLabel.translatesAutoresizingMaskIntoConstraints = false
            synonymLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            synonymLabel.text = synonym
            synonymLabel.numberOfLines = 0
            synonymLabel.lineBreakMode = .byWordWrapping
            synonymLabel.textColor = UIColor(named: "DWBlue")
            
            synonymsStackView.addArrangedSubview(synonymLabel)
        }
        
        stackView.addArrangedSubview(synonymsStackView)
    }
    
    private func setUpAntonymStackView() {
        guard let antonyms = wordResult.antonyms, !antonyms.isEmpty else {
            return
        }
    
        antonymsStackView.addArrangedSubview(antonymsTitleLabel)
        
        NSLayoutConstraint.activate([
            antonymsTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for antonym in antonyms {
            
            let antonymLabel = UILabel()
            antonymLabel.translatesAutoresizingMaskIntoConstraints = false
            antonymLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            antonymLabel.text = antonym
            antonymLabel.numberOfLines = 0
            antonymLabel.lineBreakMode = .byWordWrapping
            antonymLabel.textColor = UIColor(named: "DWBlue")
            
            antonymsStackView.addArrangedSubview(antonymLabel)
        }
        
        stackView.addArrangedSubview(antonymsStackView)

    }
    
    private func setUpExamplesStackView() {
        
        guard let examples = wordResult.examples, !examples.isEmpty else {
            return
        }
    
        examplesStackView.addArrangedSubview(examplesTitleLabel)
        
        NSLayoutConstraint.activate([
            examplesTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for example in examples {
            
            let exampleLabel = UILabel()
            exampleLabel.translatesAutoresizingMaskIntoConstraints = false
            exampleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            exampleLabel.text = example
            exampleLabel.numberOfLines = 0
            exampleLabel.lineBreakMode = .byWordWrapping
            exampleLabel.textColor = UIColor(named: "DWBlue")
            
            examplesStackView.addArrangedSubview(exampleLabel)
        }
        
        stackView.addArrangedSubview(examplesStackView)

    }
    
    
    private func addEmptyView() {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        
    }
    
}
