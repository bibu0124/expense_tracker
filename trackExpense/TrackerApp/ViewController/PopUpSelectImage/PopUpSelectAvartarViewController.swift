//
//  PopUpSelectAvartarViewController.swift
//  VietEduApp
//
//  Created by Admin on 29/08/2023.
//

import UIKit
struct SelectImageModel {
    var titleImage : String?
    var isSelected = false
}
class PopUpSelectAvartarViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(nibWithCellClass: ImageCollectionViewCell.self)
        }
    }
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    //MARK: OTHER VARIABLES
    var dataSourceImage = [UIImage(named: "avt-01") ,UIImage(named: "avt-02"),UIImage(named: "avt-03"),UIImage(named: "avt-04"),UIImage(named: "avt-05"),UIImage(named: "avt-06"),UIImage(named: "avt-07"),UIImage(named: "avt-08")]
    var numberColumn = 4
    var selectImage : UIImage?
    var imageString : String?
    var didSelectClosure : ((UIImage?)->())?
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.collectionView.observationInfo != nil {
            self.collectionView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
        
    }
    
    func setupUI() {
        
    }
    
    //MARK - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL DATA
    func fillData() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    
    //MARK: - BUTTON ACTIONS
    
    
    @IBAction func didSelectDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didSelectSave(_ sender: Any) {
        self.dismiss(animated: true){
            self.didSelectClosure?(self.selectImage)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if (change?[.newKey]) != nil {
                let photosCollectionHeight: CGFloat = collectionView.contentSize.height
                self.heightCollectionView.constant = photosCollectionHeight
            }
        }
    }
    
}
extension PopUpSelectAvartarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageAvatar.image = dataSourceImage[indexPath.row]
        self.selectImage = dataSourceImage[indexPath.row]
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ImageCollectionViewCell.self, for: indexPath)
        cell.imageAvatar.image = dataSourceImage[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(numberColumn) - 10
        return CGSize(width: width , height: 110)
    }
}
