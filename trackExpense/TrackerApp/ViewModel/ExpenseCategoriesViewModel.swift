//
//  ViewModel.swift
//  TrackerApp
//
//  Created by duynt0124 on 08/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class ExpenseCategoriesViewModel: NSObject {
    private let db = Firestore.firestore()
    private let usersCollection = Firestore.firestore().collection("users")
    
    private let userId: String
    
    override init() {
        self.userId = Token().userId ?? ""
    }
    
    var categories: [Category] = []
    
    // Fetch expense categories from Firestore
    func fetchExpenseCategories(completion: @escaping ([Category]) -> Void) {
        let userRef = usersCollection.document(userId)
        let categoriesCollection = userRef.collection("categories")
        
        Utils.shared.showLoading()
        categoriesCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching expense categories: \(error.localizedDescription)")
                Utils.shared.hideLoading()
                return
            }
            
            var fetchedCategories: [Category] = []
            for document in querySnapshot?.documents ?? [] {
                if let name = document["name"] as? String{
                    fetchedCategories.append(Category(id: document.documentID, name: name, hexCode: "FFFFFF"))
                }
                
            }
            
            self.categories = fetchedCategories
            Utils.shared.hideLoading()
            completion(fetchedCategories)
        }
    }
    func doesCategoryExist(name: String) -> Bool {
        return categories.contains { model in
            return model.name.lowercased() == name.lowercased()
        }
    }
    // Create a new expense category
    func createExpenseCategory(name: String, hex: String = "FFFFFF",completion: @escaping (Error?) -> Void) {
        let userRef = usersCollection.document(userId)
        let categoriesCollection = userRef.collection("categories")
        
        // Check if the category already exists
        categoriesCollection.whereField("name", isEqualTo: name.uppercased()).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking if category exists: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            if let existingCategory = querySnapshot?.documents.first {
                // Category already exists, handle this case as needed
                let categoryData = existingCategory.data()
                if let categoryName = categoryData["name"] as? String {
                    let customError = CustomError.error(categoryName)
                    completion(customError)
                }
            } else {
                // Category does not exist, proceed to create it
                let newCategoryRef = categoriesCollection.document()
                
                let categoryData: [String: Any] = [
                    "name": name.uppercased(),
                    "hex": hex
                ]
                
                let batch = Firestore.firestore().batch()
                batch.setData(categoryData, forDocument: newCategoryRef)
                
                batch.commit { error in
                    if let error = error {
                        print("Error creating expense category: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Expense category created successfully.")
                        completion(nil)
                    }
                }
            }
        }
        
        
    }
    
    // Delete an expense category
    func deleteCategory(categoryId: String, completion: @escaping (Error?) -> Void) {
        let userRef = usersCollection.document(userId)
        let categoriesCollection = userRef.collection("categories")
        
        let categoryRef = categoriesCollection.document(categoryId)
        
        categoryRef.delete { error in
            if let error = error {
                print("Error deleting category: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Category deleted successfully.")
                completion(nil)
            }
        }
    }
}

enum CustomError: Error {
    case error(_ name: String)
}
