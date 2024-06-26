//
//  BannerView.swift
//  TouTiao
//
//  Created by RalphHan on 2021/5/6.
//

import SwiftUI
import SDWebImageSwiftUI

//let images:[String]=["twinlake","icybay","hiddenlake"]
struct BannerView: View {
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @State var dragOffset: CGFloat = .zero

    @State var currentIndex: Int = 0

    @State var isAnimation: Bool = true
    let covers:[String]
    let spacing: CGFloat = 10
    let width: CGFloat = 350
    let height: CGFloat = 200
    var body: some View {
        let currentOffset = CGFloat(currentIndex) * (width + spacing)
        HStack(spacing: spacing){
             
            ForEach(0..<covers.count){
                   
                WebImage(url:URL(string:covers[$0])).resizable()
                    /// 自己尝试一下.fill和.fit
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width,height: $0 == currentIndex ? height:height*0.8)
                    .clipped() /// 裁减
                    .cornerRadius(10)
            }
        }.frame(width:width,
                height:height,alignment:.leading)
          .offset(x: dragOffset - currentOffset)
         .gesture(dragGesture)
         /// 绑定是否需要动画
         .animation(isAnimation ?.spring():.none)
         /// 监听当前索引的变化,最开始初始化为0是不监听的，
         .onChange(of: currentIndex, perform: { value in

            isAnimation=true
            if value == covers.count {

                isAnimation.toggle()
                currentIndex = 0
            }
         })
         .onReceive(timer, perform: { _ in
            currentIndex += 1
         })
    }
}
extension BannerView{
    private var dragGesture: some Gesture{
             
            DragGesture()
                /// 拖动改变
                .onChanged {
                     
                    isAnimation = true
                    dragOffset = $0.translation.width
                }
                /// 结束
                .onEnded {
                     
                    dragOffset = .zero
                    /// 拖动右滑，偏移量增加，显示 index 减少
                    if $0.translation.width > 50{
                        currentIndex -= 1
                    }
                    /// 拖动左滑，偏移量减少，显示 index 增加
                    if $0.translation.width < -50{
                        currentIndex += 1
                    }
                    /// 防止越界
                    currentIndex = max(min(currentIndex, covers.count - 1), 0)
                }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(covers: ["https://p1-tt-ipv6.byteimg.com/img/pgc-image/1c2070a71fb7431d9405b85f95570676~tplv-tt-cs0:300:196.image?from=feed","https://p1-tt-ipv6.byteimg.com/img/pgc-image/7a1b4f9a6baf4d7480fb3bc727e822d9~tplv-tt-cs0:300:196.image?from=feed"])
    }
}
