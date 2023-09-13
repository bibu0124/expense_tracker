//
//  SignInViewController.swift
//  VietEduApp
//
//  Created by Admin on 19/08/2023.
//

import UIKit
import AKNumericFormatter
import FirebaseAuth

enum TypeSignInOrSignUp : Int{
    case kSignIn = 1
    case kSignUp = 2
}
class SignInViewController: UIViewController {
    //MARK: IBOUTLETS
    
    @IBOutlet weak var segmentedControl: HBSegmentedControl!
    @IBOutlet weak var tfConfirmPassword: UITextField!{
        didSet{
            tfConfirmPassword.addTarget(self, action: #selector(textFieldDidConfirmPassword), for: .editingChanged)
        }
    }
    @IBOutlet weak var tfPassword: UITextField!{
        didSet{
            tfPassword.addTarget(self, action: #selector(textFieldDidPassword), for: .editingChanged)
        }
    }
    @IBOutlet weak var tfPhone: UITextField!{
        
        didSet{
            tfPhone.addTarget(self, action: #selector(textFieldDidChangePhone), for: .editingChanged)
        }
    }
    @IBOutlet weak var lblTextGoToSignIn: UILabel!
    @IBOutlet weak var btnChangeTittleLogin: UIButton!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var lblTextPassword: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var lblTextConfirmPassword: UILabel!
    @IBOutlet weak var lblTextPhoneNumber: UILabel!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var btnShowConfirmPassword: UIButton!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    //MARK: OTHER VARIABLES

    var setTypeSignIn : TypeSignInOrSignUp = .kSignIn
    var viewModel = AuthenViewModel()
    var userModel : UserModel?
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
        hiddenInterTextField()
    }
    
    func hiddenInterTextField(){
        lblTextPassword.isHidden = true
        lblTextPhoneNumber.isHidden = true
        lblTextConfirmPassword.isHidden = true
        viewPhoneNumber.borderColor = APP_SILVER_COLOR
        viewPassword.borderColor = APP_SILVER_COLOR
        viewConfirmPassword.borderColor = APP_SILVER_COLOR
    }
    
    @objc func textFieldDidChangePhone() {
        if tfPhone.text == "" || tfPhone.text?.isWhitespace == nil{
            lblTextPhoneNumber.isHidden = true
            viewPhoneNumber.borderColor = APP_SILVER_COLOR
        }else{
            lblTextPhoneNumber.isHidden = false
            viewPhoneNumber.borderColor = APP_TEXT_COLOR
        }
    }
    
    @objc func textFieldDidPassword() {
        if tfPassword.text == "" || tfPassword.text?.isWhitespace == nil{
            lblTextPassword.isHidden = true
            viewPassword.borderColor = APP_SILVER_COLOR
        }else{
            lblTextPassword.isHidden = false
            viewPassword.borderColor = APP_TEXT_COLOR
        }
    }
    
    @objc func textFieldDidConfirmPassword() {
        if tfConfirmPassword.text == "" || tfConfirmPassword.text?.isWhitespace == nil{
            lblTextConfirmPassword.isHidden = true
            viewConfirmPassword.borderColor = APP_SILVER_COLOR
        }else{
            lblTextConfirmPassword.isHidden = false
            viewConfirmPassword.borderColor = APP_TEXT_COLOR
        }
    }
    
    
    
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
        
        segmentedControl.items = ["SIGN IN", "SIGN UP"]
        segmentedControl.borderColor = .clear
        segmentedControl.selectedIndex = 0
        segmentedControl.selectedLabelColor = .white
        segmentedControl.unselectedLabelColor = .black
        segmentedControl.thumbColor = APP_TEXT_COLOR
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        
        let phoneNumber = NSMutableAttributedString(string: "Phone Number")
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.gray])
        phoneNumber.append(asterix)
        
        let password = NSMutableAttributedString(string: "Password")
        let asterixPasswoed = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.gray])
        password.append(asterixPasswoed)
        
        let confirmPassword = NSMutableAttributedString(string: "Confirm Password")
        let asterixConfirm = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.gray])
        confirmPassword.append(asterixConfirm)
    
        //self.setUiSignIn(type: self.setTypeSignIn)
        self.setUiSignIn(type: .kSignIn)
        
    }
    
    func setUiSignIn(type : TypeSignInOrSignUp){
        tfPhone.text = ""
        tfPassword.text = ""
        tfConfirmPassword.text = ""
        self.setTypeSignIn = type
        lblTextPassword.isHidden = true
        lblTextPhoneNumber.isHidden = true
        lblTextConfirmPassword.isHidden = true
        viewPassword.borderColor = APP_SILVER_COLOR
        viewPhoneNumber.borderColor = APP_SILVER_COLOR
        viewConfirmPassword.borderColor = APP_SILVER_COLOR
        if type == .kSignIn{
            let textGotoSignInString = "You're new here ? Sign Up"
            let textGotoSignAttributedText = NSMutableAttributedString(string: textGotoSignInString)
            let highlightColor1 = APP_TEXT_COLOR
            textGotoSignAttributedText.addColor(string: "Sign Up", color: highlightColor1)
            lblTextGoToSignIn.attributedText = textGotoSignAttributedText
            lblTextGoToSignIn.isUserInteractionEnabled = true
            
            viewConfirmPassword.isHidden = true
            btnChangeTittleLogin.setTitle("SIGN IN", for: UIControl.State.normal)
            segmentedControl.selectedIndex = 0
        }else{
            let textGotoSignInString = "You already have an account ? Sign In"
            let textGotoSignAttributedText = NSMutableAttributedString(string: textGotoSignInString)
            let highlightColor1 = APP_TEXT_COLOR
            textGotoSignAttributedText.addColor(string: "Sign In", color: highlightColor1)
            lblTextGoToSignIn.attributedText = textGotoSignAttributedText
            lblTextGoToSignIn.isUserInteractionEnabled = true
            
            viewConfirmPassword.isHidden = false
            btnChangeTittleLogin.setTitle("SIGN UP", for: UIControl.State.normal)
            segmentedControl.selectedIndex = 1
        }
    }
    
    
    @objc func tapForgotPasswordLabel(gesture: UITapGestureRecognizer) {
        
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        if segmentedControl.selectedIndex == 0 {
            setUiSignIn(type: .kSignIn)
        } else {
            setUiSignIn(type: .kSignUp)
        }
    }
    
    func login(){
        guard let email = tfPhone.text, email.isNotEmpty else {
            showAlert(title: kErrorTitle, message: kMsgEmail) {
                self.tfPhone.becomeFirstResponder()
            }
            return
        }
        guard let password = tfPassword.text, !password.isWhitespace else {
            showAlert(title: kErrorTitle, message: kMsgEmptyPassword) {
                self.tfPassword.becomeFirstResponder()
            }
            return
        }
        
        guard password.count >= 6 else {
            showAlert(title: kErrorTitle, message: kMsgMinimumPasswordLength) {
                self.tfPassword.becomeFirstResponder()
            }
            return
        }
        Utils.shared.showLoading()
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // Handle login error
                Utils.shared.hideLoading()
                self.showAlert(title: kErrorTitle, message: error.localizedDescription)
            } else {
                if let user = result?.user {
                    var token = Token()
                    token.userId = user.uid
                    print("User UID: \(token.userId)")
                }
                Utils.shared.hideLoading()
                Utils.shared.gotoHome()
            }
        }
    }
    
    func register(){
        guard let email = tfPhone.text, email.isNotEmpty else {
            showAlert(title: kErrorTitle, message: kMsgEmail) {
                self.tfPhone.becomeFirstResponder()
            }
            return
        }
        guard let password = tfPassword.text, !password.isWhitespace else {
            showAlert(title: kErrorTitle, message: kMsgEmptyPassword) {
                self.tfPassword.becomeFirstResponder()
            }
            return
        }
        
        guard password.count >= 6 else {
            showAlert(title: kErrorTitle, message: kMsgMinimumPasswordLength) {
                self.tfPassword.becomeFirstResponder()
            }
            return
        }
        
        guard let confirmNewPassword = tfConfirmPassword.text, !confirmNewPassword.isEmpty else {
            showAlert(title: kErrorTitle, message: kMsgEmptyConfirmPassword) {
                self.tfConfirmPassword.becomeFirstResponder()
            }
            return
        }
        
        guard password == confirmNewPassword else {
            showAlert(title: kErrorTitle, message: kMsgEnterPassword) {
                self.tfConfirmPassword.becomeFirstResponder()
            }
            return
        }
        Utils.shared.showLoading()
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else{
                Utils.shared.hideLoading()
                return
            }
            guard error == nil else{
                Utils.shared.hideLoading()
                strongSelf.showAlert(title: kErrorTitle, message: error?.localizedDescription)
                return
            }
            if let user = result?.user {
                var token = Token()
                token.userId = user.uid
                print("User UID: \(token.userId)")
            }
            Utils.shared.hideLoading()
            Utils.shared.gotoHome()
            
            
        }
        
    }
    
    func setupUI() {
        
    }
    
    //MARK - CALL API
    func callAPI() {
        
        
    }
    
    
    //MARK: - FILL DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    
    
    @IBAction func didSelectHideConfirmPassword(_ sender: UIButton) {
        self.tfConfirmPassword.isSecureTextEntry = !self.tfConfirmPassword.isSecureTextEntry
        sender.setTitle(self.tfConfirmPassword.isSecureTextEntry == true ? "Show" : "Hidden", for: .normal)
    }
    
    @IBAction func didSelectShowHidePassword(_ sender: UIButton) {
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
        sender.setTitle(self.tfPassword.isSecureTextEntry == true ? "Show" : "Hidden", for: .normal)
    }
    
    @IBAction func didSelectLoginOrSignUp(_ sender: Any) {
        if setTypeSignIn == .kSignIn{
            self.login()
        }else{
            self.register()
        }
        
    }
    
    @IBAction func didSelectChangeScreenSignInOrSignUp(_ sender: Any) {
        if setTypeSignIn == .kSignIn {
            setUiSignIn(type: .kSignUp)
        }else{
            setUiSignIn(type: .kSignIn)
        }
    }
    
    
}
