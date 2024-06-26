//
//  LandmarkDetail.swift
//  TouTiao
//
//  Created by RalphHan on 2021/4/21.
//

import SwiftUI
import WebKit
struct LandmarkDetail: View {
    var cell: Cell
    @StateObject var webViewStore = WebViewStore()
    @State var my_cell_add:Cell?=nil
    var body: some View {
      NavigationView {
        VStack{
            WebView(webView: webViewStore.webView)
          .navigationBarTitle(Text(verbatim: cell.title ?? ""), displayMode: .inline)
          .navigationBarItems(trailing: HStack {
            Button(action: goBack) {
              Image(systemName: "chevron.left")
                .imageScale(.large)
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            }.disabled(!webViewStore.canGoBack)
            Button(action: goForward) {
              Image(systemName: "chevron.right")
                .imageScale(.large)
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
            }.disabled(!webViewStore.canGoForward)
          })
            if cell.cell_type==0,let tmp=my_cell_add{
                NavigationLink(destination: LandmarkDetail(cell: tmp)) {
                    LandmarkRow(cell: tmp)
                }
            }
        }
      }.onAppear {
        self.webViewStore.webView.load(URLRequest(url: URL(string: cell.article_url)!))
        if cell.cell_type==0{
            DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 100)) {
                loadadd(){isValid in
                    DispatchQueue.main.async {
                        if isValid{
                            my_cell_add=cell_add
                        }
                   }
                }
            }
        }
      }
    }
    
    func goBack() {
      webViewStore.webView.goBack()
    }
    
    func goForward() {
      webViewStore.webView.goForward()
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        Text("nihao")
    }
}
