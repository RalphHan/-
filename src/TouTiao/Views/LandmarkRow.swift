/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI
import SDWebImageSwiftUI
struct LandmarkRow: View {
    var cell: Cell

    var body: some View {
        if cell.cell_type==0 /*&& arc4random() % 100>20*/{
            if cell.covers.count==0{
                VStack(alignment: .leading){
                    Text(cell.title)
                    AuthorView(cell:cell)
                }
            }else if cell.covers.count<3{
                HStack {
                    VStack(alignment: .leading){
                        Text(cell.title)
                        AuthorView(cell:cell)
                    }
                    WebImage(url:URL(string:cell.covers[0])).resizable().scaledToFit()
                }
            }else{
                VStack(alignment: .leading){
                    Text(cell.title)
                    HStack{
                        ForEach(0..<3) { i in
                            WebImage(url:URL(string:cell.covers[i])).resizable().scaledToFit()
                        }
                    }
                    AuthorView(cell:cell)
                }
            }
        }else{
            VStack(alignment: .leading){
                Text(cell.title)
                if cell.covers.count==1{
                    WebImage(url:URL(string:cell.covers[0])).resizable().scaledToFit()
                }else if cell.covers.count>1{
                    BannerView(covers:cell.covers)
                }
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("nihao")
            .multilineTextAlignment(.leading)
            .padding()
    }
}
