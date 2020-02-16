//
// DefaultAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class DefaultAPI {
    /**
     Create task

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPITaskCreate(body: Body? = nil, completion: @escaping ((_ data: InlineResponse201?,_ error: Error?) -> Void)) {
        appHttpControllersAPITaskCreateWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Create task
     - POST /tasks
     - 

     - :
       - type: http
       - name: bearerAuth
     - examples: [{contentType=application/json, example={
  "task" : {
    "id" : 43,
    "title" : "Meeting",
    "dueBy" : 1549477494,
    "priority" : "High"
  }
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<InlineResponse201> 
     */
    open class func appHttpControllersAPITaskCreateWithRequestBuilder(body: Body? = nil) -> RequestBuilder<InlineResponse201> {
        let path = "/tasks"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse201>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Delete a task

     - parameter task: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPITaskDelete(task: Int, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        appHttpControllersAPITaskDeleteWithRequestBuilder(task: task).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Delete a task
     - DELETE /tasks/{task}
     - 

     - :
       - type: http
       - name: bearerAuth
     - parameter task: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func appHttpControllersAPITaskDeleteWithRequestBuilder(task: Int) -> RequestBuilder<Void> {
        var path = "/tasks/{task}"
        let taskPreEscape = "\(task)"
        let taskPostEscape = taskPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{task}", with: taskPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Task's details

     - parameter task: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPITaskGet(task: Int, completion: @escaping ((_ data: InlineResponse201?,_ error: Error?) -> Void)) {
        appHttpControllersAPITaskGetWithRequestBuilder(task: task).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Task's details
     - GET /tasks/{task}
     - 

     - :
       - type: http
       - name: bearerAuth
     - examples: [{contentType=application/json, example={
  "task" : {
    "id" : 43,
    "title" : "Meeting",
    "dueBy" : 1549477494,
    "priority" : "High"
  }
}}]
     - parameter task: (path)  

     - returns: RequestBuilder<InlineResponse201> 
     */
    open class func appHttpControllersAPITaskGetWithRequestBuilder(task: Int) -> RequestBuilder<InlineResponse201> {
        var path = "/tasks/{task}"
        let taskPreEscape = "\(task)"
        let taskPostEscape = taskPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{task}", with: taskPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse201>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update a task

     - parameter task: (path)  
     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPITaskUpdate(task: Int, body: Body1? = nil, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        appHttpControllersAPITaskUpdateWithRequestBuilder(task: task, body: body).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Update a task
     - PUT /tasks/{task}
     - 

     - :
       - type: http
       - name: bearerAuth
     - parameter task: (path)  
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func appHttpControllersAPITaskUpdateWithRequestBuilder(task: Int, body: Body1? = nil) -> RequestBuilder<Void> {
        var path = "/tasks/{task}"
        let taskPreEscape = "\(task)"
        let taskPostEscape = taskPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{task}", with: taskPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Authorize a user by credentials

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPIUserAuth(body: Body3? = nil, completion: @escaping ((_ data: InlineResponse2001?,_ error: Error?) -> Void)) {
        appHttpControllersAPIUserAuthWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Authorize a user by credentials
     - POST /auth

     - examples: [{contentType=application/json, example={
  "token" : "token"
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<InlineResponse2001> 
     */
    open class func appHttpControllersAPIUserAuthWithRequestBuilder(body: Body3? = nil) -> RequestBuilder<InlineResponse2001> {
        let path = "/auth"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse2001>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Add a new user

     - parameter body: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func appHttpControllersAPIUserCreate(body: Body2? = nil, completion: @escaping ((_ data: InlineResponse2001?,_ error: Error?) -> Void)) {
        appHttpControllersAPIUserCreateWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Add a new user
     - POST /users
     - 

     - examples: [{contentType=application/json, example={
  "token" : "token"
}}]
     - parameter body: (body)  (optional)

     - returns: RequestBuilder<InlineResponse2001> 
     */
    open class func appHttpControllersAPIUserCreateWithRequestBuilder(body: Body2? = nil) -> RequestBuilder<InlineResponse2001> {
        let path = "/users"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<InlineResponse2001>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Tasks list

     - parameter page: (query) a page number (optional)
     - parameter sort: (query) a sorting filter. Composed by a field name and sort direction (asc/desc) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func tasksGet(page: Int? = nil, sort: String? = nil, completion: @escaping ((_ data: InlineResponse200?,_ error: Error?) -> Void)) {
        tasksGetWithRequestBuilder(page: page, sort: sort).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Tasks list
     - GET /tasks
     - 

     - :
       - type: http
       - name: bearerAuth
     - examples: [{contentType=application/json, example={
  "meta" : {
    "current" : 1,
    "limit" : 15,
    "count" : 14
  },
  "tasks" : [ {
    "id" : 43,
    "title" : "Meeting",
    "dueBy" : 1549477494,
    "priority" : "High"
  }, {
    "id" : 43,
    "title" : "Meeting",
    "dueBy" : 1549477494,
    "priority" : "High"
  } ]
}}]
     - parameter page: (query) a page number (optional)
     - parameter sort: (query) a sorting filter. Composed by a field name and sort direction (asc/desc) (optional)

     - returns: RequestBuilder<InlineResponse200> 
     */
    open class func tasksGetWithRequestBuilder(page: Int? = nil, sort: String? = nil) -> RequestBuilder<InlineResponse200> {
        let path = "/tasks"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "page": page?.encodeToJSON(), 
                        "sort": sort
        ])

        let requestBuilder: RequestBuilder<InlineResponse200>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}