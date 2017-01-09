//
//  PSSpider.swift
//  PullServer
//
//  Created by AugustRush on 1/5/17.
//
//

import Foundation

enum SpiderError: Error {
    case urlInvalid
    case dataError
    case parseDataError
    
    func description() -> String {
        switch self {
        case .urlInvalid:
            return "url is invalidate!"
        case .dataError:
            return "data is error!"
        case .parseDataError:
            return "parse data to string error!"
        }
    }
}

class PSSpider {
    
    static func crawlHTML(fromURL: String, completion: @escaping (String) -> Void, failed: @escaping (SpiderError) -> Void) {
        DispatchQueue.global().async {
            let url = URL.init(string: "http://www.hahao.cn/feed/")
            guard let _ = url else {
                failed(SpiderError.urlInvalid)
                return
            }
            let data = NSData.init(contentsOf: url!)
            guard let _ = data else {
                failed(SpiderError.dataError)
                return
            }
            let xmlString = String.init(data: data as! Data, encoding: .utf8)
            guard let _ = xmlString else {
                failed(SpiderError.parseDataError)
                return
            }
            completion(xmlString!)
        }
    }
}
