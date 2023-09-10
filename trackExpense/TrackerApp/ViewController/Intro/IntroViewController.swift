//
//  IntroViewController.swift
//  VietEduApp
//
//  Created by Admin on 17/08/2023.
//

import UIKit
import PopupDialog
class IntroViewController: UIViewController {
    
    
    //MARK: IBOUTLETS
    
    //MARK: OTHER VARIABLES
    
    
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
    }
    
    
    @IBAction func didSelectSignIn(_ sender: Any) {
        let vc = SignInViewController()
        vc.setTypeSignIn = .kSignIn
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    @IBAction func didSelectSignUp(_ sender: Any) {
        // introview
        let vc = SignInViewController()
        vc.setTypeSignIn = .kSignUp
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
