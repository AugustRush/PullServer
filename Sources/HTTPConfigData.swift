//
//  HTTPConfigData.swift
//  PullServer
//
//  Created by AugustRush on 1/5/17.
//
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer

// Request APIs
func getChannel(data: [String:Any]) throws -> RequestHandler {
    
    let handler: RequestHandler = {
        request, response in
        // Respond with a simple message.
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: try! ["天气",
                                          "文章收藏"].jsonEncodedString())
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
    
    return handler
}

func createChannel(data: [String:Any]) throws -> RequestHandler {
    
    let handler: RequestHandler = {
        request, response in
        // Respond with a simple message.
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: try! ["errorCode":"0"].jsonEncodedString())
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }
    
    return handler
}

/// All Routes
let allRoutes = [
    ["method":"post", "uri":"/getchannel", "handler":getChannel],
    ["method":"post", "uri":"/createchannel", "handler":createChannel],
    ["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
     "documentRoot":"./webroot",
     "allowResponseFilters":true]
]

let confData = [
    "servers": [
        // Configuration data for one server which:
        //	* Serves the hello world message at <host>:<port>/
        //	* Serves static files out of the "./webroot"
        //		directory (which must be located in the current working directory).
        //	* Performs content compression on outgoing data when appropriate.
        [
            "name":"localhost",
            "port":port1,
            "routes":allRoutes,
            "filters":[
                [
                    "type":"response",
                    "priority":"high",
                    "name":PerfectHTTPServer.HTTPFilter.contentCompression,
                    ]
            ]
        ],
        // Configuration data for another server which:
        //	* Redirects all traffic back to the first server.
        [
            "name":"localhost",
            "port":port2,
            "routes":allRoutes
        ]
    ]
]
