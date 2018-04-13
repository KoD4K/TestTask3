//
//  Server.swift
//  TestTask3
//
//  Created by Evgeny Plenkin on 13/04/2018.
//  Copyright © 2018 Evgeny Plenkin. All rights reserved.
//

import RxSwift
import ObjectMapper
import Alamofire
import SwiftyJSON

class Server {
    private func sendPostRequest<T:Mappable>(_ request: Request) -> Observable<T> {
        return sendRequest(request: request, method: .post)
    }
    private func sendGetRequest<T:Mappable>(_ request: Request) -> Observable<T> {
        return sendRequest(request: request, method: .get)
    }
    
    //MARK: - RX REQUEST
    
    func sendRequest<T: Mappable>(request: Request, method: HTTPMethod) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = Alamofire.request(request.url, method: method).responseJSON { response in
                self.handle(response, with: observer)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func handle<T: Mappable>(_ response: DataResponse<Any>, with observer: AnyObserver<T>) {
        switch response.result {
        case .success(let value):
            self.onSuccessResponse(with: observer, value: value)
        case .failure(let error):
            self.onFailureResponse(with: observer, and: error)
        }
    }
    
    func onSuccessResponse<T: Mappable>(with observer: AnyObserver<T>, value: Any) {
        let json = JSON(value)
        
        if let dictionary = json.dictionaryObject {

            guard let mappedObject = T(JSON: dictionary) else {
                return
            }
            
            observer.onNext(mappedObject)
            observer.onCompleted()
        }
    }
    
    func onFailureResponse<T: Mappable>(with observer: AnyObserver<T>, and error: Error) {
        let nsError = error as NSError
        
        observer.onError(nsError)
    }
    
    //REQUSETS
    
    func loadQoutations() -> Observable<QoutationsResponse> {
        let request = Request()
        return sendGetRequest(request)
    }
}
