//
//  AuthorView.swift
//  TouTiao
//
//  Created by RalphHan on 2021/5/13.
//

import SwiftUI
import SDWebImageSwiftUI
struct AuthorView: View {
    var cell: Cell
    var body: some View {
        HStack{
            if cell.avatar != ""{
            WebImage(url:URL(string:cell.avatar)).resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 2)
            }
            Text(cell.author_name).foregroundColor(Color.gray).font(.system(size:14))
            Text(cell.publish_time).foregroundColor(Color.gray).font(.system(size:14))
        }
    
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        Text("pass")
    }
}
