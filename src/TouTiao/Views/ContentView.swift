/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the list of landmarks.
*/

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        let tad = DragGesture()
            .onEnded{ value in
                if(value.translation.width > 30 && value.translation.height < 30 && value.translation.height > -30 && selectedTab>0) {
                    selectedTab-=1
                }else if (value.translation.width < -30 && value.translation.height < 30 && value.translation.height > -30 && selectedTab<3) {
                    selectedTab+=1
                }
            }

        TabView(selection: $selectedTab) {
            LandmarkList(cate: 0)
                .tabItem {
                    Image("all")
                    Text("推荐")
                }
                .tag(0)

            LandmarkList(cate: 1)
                .tabItem {
                    Image("tech")
                    Text("科技")
                }
                .tag(1)
            LandmarkList(cate: 2)
                .tabItem {
                    Image("military")
                    Text("军事")
                }
                .tag(2)
            LandmarkList(cate: 3)
                .tabItem {
                    Image("entertainment")
                    Text("娱乐")
                }
                .tag(3)
        }.gesture(tad)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
