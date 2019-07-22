//
//  ThingProvider.swift
//  thing
//
//  Created by 박진하 on 2019/06/19.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation
import Moya
import Result

class ThingProvider {
    static let provider = MoyaProvider<ThingService>()

    class func signIn(completion: @escaping ((User) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.signIn) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    class func signUp(uid: String, nickname: String, gender: Int?, birth: Int?, completion: @escaping ((Data?) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.signUp(uid: uid, nickname: nickname, gender: gender, birth: birth)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    class func categories(categoryId: Int, filter: String, page: Int, completion: @escaping ((Rankings) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.categories(categoryId: categoryId, filter: filter, page: page)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    class func youtuber(id: Int, completion: @escaping ((Youtuber) -> Void), failure: @escaping ((Error) -> Void)) {
        provider.request(.youtuber(id: id)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
}

extension ThingProvider {
    class func resultTask<T: Decodable>(_ result: Result<Response, MoyaError>, completion: @escaping ((T) -> Void), failure: @escaping ((Error) -> Void)) {
        switch result {
        case .success(let response):
            Log(try? response.mapJSON())
            let data = response.data
            let statusCode = response.statusCode

            if let body = try? JSONDecoder().decode(T.self, from: data), statusCode < 300 {
                completion(body)
            } else {
                if let error = try? JSONDecoder().decode(U2UError.self, from: data) {
                    let nsError: NSError = NSError(domain: error.error.massage, code: error.error.code, userInfo: nil)
                    failure(nsError)
                } else if let data = data as? T {
                    completion(data)
                } else {
                    failure(NSError(domain: "Unknown", code: -9999, userInfo: nil))
                }
            }
        case let .failure(error):
            failure(error)
        }
    }
}
