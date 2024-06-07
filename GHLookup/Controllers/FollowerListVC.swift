//
//  FollowerListVC.swift
//  GHLookup
//
//  Created by JJ on 10/05/24.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject{
    func didRequestFollowers(for username:String)
}

class FollowerListVC: UIViewController {
    //MARK: - properties
    var username: String!
    var collectionView: UICollectionView!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isLoadingMoreFollowers = false
    var isSearching = false
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    //MARK: - lifecycle
    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //MARK: - helpers
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveUser))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView(){
        //initialize the collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        //Set the FollowerListVC as the delegate
        collectionView.delegate = self
        //Add it to the subview
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    
    func getFollowers(username:String, page:Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀."
                    DispatchQueue.main.async {
                        self.showEmptyState(with: message, in: self.view)
                    }
                    return
                    
                }
                self.updateData(on: self.followers)
                return
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
        self.isLoadingMoreFollowers = false
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func saveUser(){
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard let error = error else {
                        self.presentGHAlertOnMainThread(title: "Success!", message: "You have succesfully favorited this user. 🥳", buttonTitle: "Hooray!")
                        return
                    }
                    self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    
                }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

//MARK: -   UICollectionViewDelegate

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}

//MARK: -  Search Controller - UISearchResultsUpdating & UISearchBarDelegate

extension FollowerListVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return}
        isSearching = true
        filteredFollowers = followers.filter({$0.login.lowercased().contains(filter.lowercased())})
        updateData(on: filteredFollowers)
    }
    
}


//MARK: - FollowerListVCDelegate

extension FollowerListVC: FollowerListVCDelegate{
    func didRequestFollowers(for username: String) {
        //get followers for that username
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
        
    }
    
    
}
