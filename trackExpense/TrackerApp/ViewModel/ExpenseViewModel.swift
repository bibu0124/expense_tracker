//
//  ExpenseViewModel.swift
//  TrackerApp
//
//  Created by duynt0124 on 08/09/2023.
//

import Firebase
import FirebaseFirestore

class ExpenseViewModel: NSObject {
    private let db = Firestore.firestore()
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let userId: String // Store the userId
    
    override init() {
        self.userId = Token().userId ?? ""
    }
    
    func createExpense(title: String, amount: Double, category: String, date: Date, address: String?, notes: String?, completion: @escaping (Error?) -> Void) {
        let userRef = usersCollection.document(userId)
        let expensesCollection = userRef.collection("expenses")
        
        let newExpenseRef = expensesCollection.document()
        
        let expenseData: [String: Any] = [
            "title": title,
            "amount": amount,
            "category": category,
            "date": Timestamp(date: date),
            "address": address,
            "notes": notes ?? ""
        ]
        
        newExpenseRef.setData(expenseData) { error in
            if let error = error {
                print("Error creating expense: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Expense created successfully.")
                completion(nil)
            }
        }
    }
    
    func updateExpense(expenseId: String, title: String, amount: Double, category: String, date: Date, address: String?, notes: String?, completion: @escaping (Error?) -> Void) {
        let userRef = usersCollection.document(userId)
        let expensesCollection = userRef.collection("expenses")
        
        let expenseRef = expensesCollection.document(expenseId)
        
        let expenseData: [String: Any] = [
            "title": title,
            "amount": amount,
            "category": category,
            "date": Timestamp(date: date),
            "address": address,
            "notes": notes ?? ""
        ]
        
        expenseRef.setData(expenseData) { error in
            if let error = error {
                print("Error updating expense: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Expense updated successfully.")
                completion(nil)
            }
        }
    }
    
    func deleteExpense(expenseId: String, completion: @escaping (Error?) -> Void) {
        let userRef = usersCollection.document(userId)
        let expensesCollection = userRef.collection("expenses")
        
        let expenseRef = expensesCollection.document(expenseId)
        
        expenseRef.delete { error in
            if let error = error {
                print("Error deleting expense: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Expense deleted successfully.")
                completion(nil)
            }
        }
    }
    
    func fetchExpenses(completion: @escaping ([Expense]) -> Void) {
        let userRef = usersCollection.document(userId)
        let expensesCollection = userRef.collection("expenses")
        Utils.shared.showLoading()
        expensesCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching expenses: \(error.localizedDescription)")
                completion([])
                Utils.shared.hideLoading()
                return
            }
            
            var expenses: [Expense] = []
            for document in querySnapshot?.documents ?? [] {
                if let title = document["title"] as? String,
                   let amount = document["amount"] as? Double,
                   let category = document["category"] as? String,
                   let address = document["address"] as? String,
                   let dateTimestamp = document["date"] as? Timestamp,
                   let notes = document["notes"] as? String {
                    
                    let date = dateTimestamp.dateValue()
                    let expense = Expense(id: document.documentID, title: title, amount: amount, category: category, date: date, address: address, notes: notes)
                    expenses.append(expense)
                }
            }
            completion(expenses)
            Utils.shared.hideLoading()
        }
    }
    
    // Fetch expenses for a specific category
    func fetchExpensesForCategory(category: String, completion: @escaping ([Expense]) -> Void) {
        let userRef = usersCollection.document(userId)
        let expensesCollection = userRef.collection("expenses")
        
        expensesCollection.whereField("category", isEqualTo: category).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching expenses for category \(category): \(error.localizedDescription)")
                completion([])
                return
            }
            
            var expenses: [Expense] = []
            for document in querySnapshot?.documents ?? [] {
                if let title = document["title"] as? String,
                   let amount = document["amount"] as? Double,
                   let category = document["category"] as? String,
                   let dateTimestamp = document["date"] as? Timestamp,
                   let address = document["address"] as? String,
                   let notes = document["notes"] as? String {
                    
                    let date = dateTimestamp.dateValue()
                    let expense = Expense(id: document.documentID, title: title, amount: amount, category: category, date: date, address: address, notes: notes)
                    expenses.append(expense)
                }
            }
            
            completion(expenses)
        }
    }
    
}
