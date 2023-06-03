//
//  PostListView.swift
//  APIGetPostDelete
//
//  Created by Razan Mohammed Alzannan on 15/11/1444 AH.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack{
            Text("GET METHOD")
                .onAppear{
                    Api().getPost()
                }
            
            Text("POST METHOD")
                .onAppear{
                    Api().postPosts()
                }
            
            Text("DELETE METHOD")
                .onAppear{
                    Api().deleteMethod()
                }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
