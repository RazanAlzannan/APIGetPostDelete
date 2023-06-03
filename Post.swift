//
//  User.swift
//  APIGetPostDelete
//
//  Created by Razan Mohammed Alzannan on 14/11/1444 AH.
//

import Foundation
struct Post : Codable, Identifiable {
    var userId : Int
    var id: Int {
        userId
    }
    var title : String
    var body : String
}

class Api {
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            print(posts)
        }
        .resume()
    }
    
    
    func postPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        var request = URLRequest (url: url)
        // method, body, headers
        request.httpMethod = "POST"
        request.setValue ("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId": 1,
            "title": "Hello From Tuwaiq Academy",
            "body": "The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog."
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("SUCCESS :\(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func deleteMethod() {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
                print("Error: cannot create URL")
                return
            }
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling DELETE")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
}


