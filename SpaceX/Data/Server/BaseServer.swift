//
//  BaseServer.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation
import FTAPIKit

struct BaseServer: URLServer {

    var baseUri: URL {
        URL(string: "https://api.spacexdata.com/")!
    }

    let decoding: Decoding = JSONDecoding { decoder in
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}
