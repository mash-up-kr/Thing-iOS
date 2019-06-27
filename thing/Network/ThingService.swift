//
//  ThingService.swift
//  thing
//
//  Created by 박진하 on 11/06/2019.
//  Copyright © 2019 mashup. All rights reserved.
//

import Foundation
import Moya

enum ThingService {
    case signUp(uid: String, nickname: String, gender: Int?, birth: Double?)
}

extension ThingService: TargetType {
	var baseURL: URL { return URL(string: "http://13.124.57.224/v2/api-docs?group=com.mashup.thing")! }

	var path: String {
        switch self {
        case .signUp:
            return "/v1/users"
		}
	}

	var method: Moya.Method {
		switch self {
		case .signUp:
			return .post
		}
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
        switch self {
        case .signUp(let uid, let nickname, let gender, let birth):
            var params: [String: Any] = ["uid": uid, "nickname": nickname]

            if let gender = gender {
                params["gender"] = gender
            }

            if let birth = birth {
                params["birth"] = birth
            }

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
		}
	}

	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}
}