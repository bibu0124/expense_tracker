//
//  AccountProfileViewController.swift
//  VietEduApp
//
//  Created by Admin on 31/08/2023.
//

import UIKit
import PopupDialog
import FirebaseAuth
enum AccountMenuType : String{

    case info = "Profile Information"
    case payment = "Payment"
    case notification = "Notification"
    case liveQA = "Live Q&A"
    case termsOfUser = "Terms of Use"
    case privacyPolicy = "Privacy Policy"
}

struct AccountMenuItem {
    var type : AccountMenuType?
    var image : UIImage?
    
    init(_ type : AccountMenuType? , _ image : UIImage?){
        self.image = image
        self.type = type
    }
    
}

class AccountProfileViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(nibWithCellClass: AccountMenuCell.self)
            tableView.tableFooterView = UIView()
        }
    }
    //MARK: IBOUTLETS
    
    //MARK: OTHER VARIABLES
    var dataSource = [AccountMenuItem]()
    var viewModel = AuthenViewModel()
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        setupVar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        callAPI()
    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
        self.navigationItem.title = "Account"
        imgAvatar.sdImageURL(Token.shared.user?.avatar_url, placeHolder: IMG_LOGO_PLACEHOLDER)
        lblName.text = FirebaseAuth.Auth.auth().currentUser?.email ?? "Duy"
    }
    
    func setupUI() {
        
    }
    
    //MARK - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL DATA
    func fillData() {
        
        tableView.reloadData()
    }
    
    //MARK: - BUTTON ACTIONS
    
    
    @IBAction func didTapEdit(_ sender: Any) {
        
    }
    
    @IBAction func didSelectLogOut(_ sender: Any) {
        showAlert(title: kNotificationTitle, message: "Do you want to sign out?", buttonTitles: ["No", "Yes"], highlightedButtonIndex: nil, completion: { (index) in
            if index == 1 {
                
                Utils.shared.showLoading()
                do{
                    Utils.shared.hideLoading()
                    try FirebaseAuth.Auth.auth().signOut()
                    Utils.shared.gotoLogin()
                }catch{
                    Utils.shared.hideLoading()
                    print("Error")
                }
            }
        })
    }
    
}
extension AccountProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        switch item.type {
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AccountMenuCell.self, for: indexPath)
        let item = dataSource[indexPath.row]
        cell.fillData(item: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
