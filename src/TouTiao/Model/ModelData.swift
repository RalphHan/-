//
//  Data.swift
//  TouTiao
//
//  Created by RalphHan on 2021/4/21.
//

import Foundation

let url="https://i.snssdk.com/mooc/stream/api/list/?"
let url_add="https://i.snssdk.com/mooc/stream/api/ad_info/"
var cell_add=Cell()
var categories=["all","tech","military","entertainment"]
var extra=["","","",""]
var has_more=[true,true,true,true]
var cells:[[Cell]]=[[],[],[],[]]

func loadmore(cate:Int,req_type:Int,completion: @escaping () -> ()){
    if !has_more[cate] && req_type==2{return}
    let urlPath0: String = "\(url)category=\(categories[cate])&request_type=\(req_type)&response_extra=\(extra[cate])"
//    let urlPath0: String = "https://i.snssdk.com/mooc/stream/api/list/?category=all&request_type=2&response_extra={}"
    let urlPath: String = urlPath0.addingPercentEncoding(withAllowedCharacters:
                                                    .urlQueryAllowed)!
    let url = URL(string: urlPath)!

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
               extra[cate] = json["extra"] as! String
               has_more[cate] = json["has_more"] as! Bool
               var tmp:[Cell]=[]
               let  dformatter =  DateFormatter ()
               dformatter.dateFormat =  "yyyy年MM月dd日 HH:mm:ss"
               for cell in json["data"] as! [AnyObject]{
                    let type=cell["cell_type"] as! Int
                    var ce=Cell()
                    ce.title=cell["title"] as! String
                    ce.article_url=cell["article_url"] as! String
                    ce.cell_type=type
                    if let covs=cell["covers"] as? [AnyObject]{
                        for cov in covs{
                            var cov_url=cov["url"] as!String
                            cov_url.insert("s", at: cov_url.index(cov_url.startIndex,offsetBy:4))
                            ce.covers.append(cov_url)
                        }
                    }
                    if type==0{
                        ce.publish_time=dformatter.string(from:Date(timeIntervalSince1970:TimeInterval(cell["publish_time"] as! Int)))
                        let author=cell["author_info"] as! AnyObject
                        ce.author_name=author["user_name"] as! String
                        var avatar=author["avatar"] as! String
                        if avatar != ""{
                            avatar.insert("s", at: avatar.index(avatar.startIndex,offsetBy:4))
                            ce.avatar=avatar
                        }
                    }
                    tmp.append(ce)
               }
               if req_type==2{cells[cate]+=tmp}
               else{cells[cate]=tmp+cells[cate]}
           } catch {}
        }
        completion()
    }
    task.resume()
}
func loadadd(completion: @escaping (Bool) -> ()){
    let url = URL(string: url_add)!

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data {
           do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                let cell = json["data"] as! AnyObject
                cell_add.title=cell["title"] as! String
                cell_add.article_url=cell["article_url"] as! String
                cell_add.cell_type=cell["cell_type"] as! Int
                cell_add.covers.removeAll()
                if let covs=cell["covers"] as? [AnyObject]{
                    for cov in covs{
                        var cov_url=cov["url"] as!String
                        cov_url.insert("s", at: cov_url.index(cov_url.startIndex,offsetBy:4))
                        cell_add.covers.append(cov_url)
                    }
                }
                completion(true)
           } catch {completion(false)}
        }else{completion(false)}
    }
    task.resume()
}
