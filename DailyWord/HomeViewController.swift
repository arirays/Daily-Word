
import UIKit
import Alamofire


class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DWRed")
        return view
    }()
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(
            string: "Daily Dose \nof Definitions",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor(named: "DWBlue") ?? .black

            ])
        return label
    }()
    
    let randomWordView: RandomWordView = {
        let randomWordView = RandomWordView()
        randomWordView.translatesAutoresizingMaskIntoConstraints = false
        randomWordView.refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        return randomWordView
    }()

    
    let definitionSearchContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let spinnerViewController = SpinnerViewController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }


    // MARK: - UI Setup
    
    private func setUpUI() {
        
        view.backgroundColor = .white
        
        setUpHeader()
        setUpRandomWordView()
        setUpDefinitionSearchContainerView()
    }
    
    
    private func setUpHeader() {
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        headerView.addSubview(headerTitle)
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            
        ])
    }
    
    
    
    private func setUpRandomWordView() {
        
        view.addSubview(randomWordView)
        
        NSLayoutConstraint.activate([
            randomWordView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            randomWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            randomWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            randomWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20)
            
        ])
    }
    
    private func setUpDefinitionSearchContainerView() {
        
        let definitionSearchViewController = DefinitionSearchViewController()
        definitionSearchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(definitionSearchViewController)
        definitionSearchContainerView.addSubview(definitionSearchViewController.view)
        definitionSearchViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            definitionSearchViewController.view.topAnchor.constraint(equalTo: definitionSearchContainerView.topAnchor),
            definitionSearchViewController.view.leadingAnchor.constraint(equalTo: definitionSearchContainerView.leadingAnchor),
            definitionSearchViewController.view.trailingAnchor.constraint(equalTo: definitionSearchContainerView.trailingAnchor),
            definitionSearchViewController.view.bottomAnchor.constraint(equalTo: definitionSearchContainerView.bottomAnchor)
        ])
        
        
        view.addSubview(definitionSearchContainerView)
        
        NSLayoutConstraint.activate([
            definitionSearchContainerView.topAnchor.constraint(equalTo: randomWordView.bottomAnchor, constant: 20),
            definitionSearchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), definitionSearchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            definitionSearchContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
    
    
    private func addSpinnerViewController() {
        
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: spinnerViewController)
    }
    
    
    private func removeSpinnerViewController() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }
    
    // MARK: - Actions
    
    
    @objc func refreshButtonPressed() {
        
        print("Refresh Button has been pressed")
        
        if let networkReachabilityManager = NetworkReachabilityManager(), networkReachabilityManager.isReachable {
            
            addSpinnerViewController()
            
            fetchRandomWordResponse { [weak self] randomWord, error in
                
                if let error = error {
                    print("Fetch random word response failed due to error: \(error.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    self?.randomWordView.addTextToLabels(usingWordDetails: randomWord)
                    self?.removeSpinnerViewController()
                    
                    
                print(randomWord)
                }
            }
        }
        else {
            print("Network is not reachable")
        }
    }
    
    
    private func fetchRandomWordResponse(completion: @escaping (WordDetails?, Error?) -> Void) {
        guard let randomWordDataURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions")
            else {
            print("Expected Random Words API URL but failed")
            return
        }
        
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "12bdf32360mshb9f878e40e89104p16a807jsn6c5f59e647d8",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        
        AF.request(randomWordDataURL, method: .get, headers: headers).responseDecodable(of: WordDetails.self) { response in
            
            guard let wordDetails = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            completion(wordDetails, response.error)
        }
        
    }
}

