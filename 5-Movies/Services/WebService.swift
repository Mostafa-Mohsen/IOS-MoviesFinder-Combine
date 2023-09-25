//
//  WebService.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import Foundation
import Alamofire
import Combine

struct RequestParameters {
    let method: HTTPMethod
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let headers: HTTPHeaders?
}

enum NetworkError: Error {
    case error(message: String)
}

class WebService {
    
    func request(urlPath: String, params: RequestParameters? = nil) -> AnyPublisher<AnyObject?, NetworkError> {
        return Future<AnyObject?, NetworkError> { promise in
            guard let url = URL(string: urlPath) else {
                promise(.failure(NetworkError.error(message: "Invalid url")))
                return
            }
            let request = AF.request(url,
                       method: params?.method ?? .get,
                       parameters: params?.parameters,
                       encoding: params?.encoding ?? URLEncoding.default,
                       headers: params?.headers)
            request.validate()
            request.responseJSON() { response in
                    print("request: \(response.request!.url!.absoluteString)")
                    switch response.result {
                        case .success(let res):
                        promise(.success(res as? AnyObject))

                        case .failure(let error):
                            var errorString: String?
                            if let data = response.data {
                                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                                    errorString = json["error"]
                                }
                            }
                        print("failure")
                        promise(.failure(NetworkError.error(message: errorString ?? error.localizedDescription)))
                    }
                            
                }
        }.eraseToAnyPublisher()
    }
}
