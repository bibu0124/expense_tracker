//
//  HomeVC.swift
//  VietEduApp
//
//  Created by Thien Truong on 8/17/23.
//

import UIKit

class HomeVC: UIViewController {
    
    
    //MARK: IBOUTLETS
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(nibWithCellClass: HomeBodyCVCell.self)
            self.collectionView.register(nibWithCellClass: AddCategoryCVCell.self)
            self.collectionView.register(nib: UINib.init(nibName: HomeCVCell.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HomeCVCell.self)
        }
    }

    //MARK: OTHER VARIABLES
    let vm = ExpenseCategoriesViewModel()
    var dataSource = [Category](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        var token = Token()
//        token.token = "7|GDv8GjkGhgNQWUUxdnhzhxNXC49PqPG6qzZzBShP"
        setupVar()
        setupUI()
        callAPI()
    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.navigationItem.title = "Categories"
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.collectionViewLayout = layout
    }
    
    //MARK - CALL API
    func callAPI() {
        vm.fetchExpenseCategories(completion: { [weak self]  categories in
            guard let self = self else { return }
            self.dataSource = categories
        })
        fillData()
    }
    
    //MARK: - FILL DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    

}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        return view
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenHeight = UIScreen.main.bounds.height
        let headerHeight = screenHeight / 3
        return CGSize(width: collectionView.bounds.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item < dataSource.count {
            let cell = collectionView.dequeueReusableCell(withClass: HomeBodyCVCell.self, for: indexPath)
            cell.fillData(dataSource[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: AddCategoryCVCell.self, for: indexPath)

            return cell
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let padding: CGFloat = 4
        let spacing: CGFloat = 16
        
        let availableWidth = collectionView.frame.width - padding * 2 - 15 * 2
        let itemWidth = availableWidth / numberOfColumns
        
        let screenHeight = UIScreen.main.bounds.height
        let height = screenHeight / 5
        
        return CGSize(width: itemWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < dataSource.count {
            let data = dataSource[indexPath.item]
            let vc = ExpensesVC()
            vc.categoryName = data.name
            self.navigationController?.pushViewController(vc)
        } else {
            addCategoryTapped()
        }
    }
    
    @objc func addCategoryTapped() {
        // Handle the "+" button tap event to create a new expense category
//        let categoryName = "Transportation" // Replace with your logic to generate a category name
//        vm.createExpenseCategory(name: categoryName) { error in
//            if let error = error {
//                // Handle the error
//                self.showAlert(title: kNotificationTitle, message: error.localizedDescription)
//            } else {
//                // Category created successfully, update your UI as needed
//
//
//
//            }
//        }
        
        let alert = SettingView.instanceFromNib()
                
        alert.show(vm: self.vm, self) { [weak self] (isRefresh) in
            guard let self = self else { return }
            if isRefresh!{
                vm.fetchExpenseCategories(completion: { [weak self]  categories in
                    guard let self = self else { return }
                    self.showAlert(title: kNotificationTitle, message: "Category created successfully")
                    self.dataSource = categories
                })
            }
        }
        
    }
}
