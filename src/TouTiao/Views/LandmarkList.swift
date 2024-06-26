//
//  LandmarkList.swift
//  TouTiao
//
//  Created by RalphHan on 2021/4/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct LandmarkList: View {
    var cate:Int = 0
    @State var count:Int=0
    @State var isDone:Bool=true
    var body: some View {
        RefreshableNavigationView(title: "今日油条", action:{
            isDone=false
            loadmore(cate:cate,req_type:1){
            DispatchQueue.main.async {
                self.count=cells[cate].count
                isDone=true
           }
            }},isDone:$isDone){
                ForEach(0..<self.count,id:\.self){i in
                    NavigationLink(destination: LandmarkDetail(cell: cells[cate][i])) {
                        LandmarkRow(cell: cells[cate][i])
                    }
                }
                Button("已经到底了"){}
                .onAppear {
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 100)) {
                        loadmore(cate:cate,req_type:2){
                            DispatchQueue.main.async {
                                count=cells[cate].count
                           }
                        }
                        
                    }
                }
        }.navigationTitle("Landmarks")
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList(cate:0)
    }
}
