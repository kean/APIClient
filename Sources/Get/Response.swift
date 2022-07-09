// The MIT License (MIT)
//
// Copyright (c) 2021-2022 Alexander Grebenyuk (github.com/kean).

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A response with a value and associated metadata.
public struct Response<T> {
    /// Decoded response value.
    public var value: T
    /// Original response data.
    public var data: Data
    /// Original request.
    public var request: URLRequest
    /// Original response.
    public var response: URLResponse
    /// Response HTTP status code.
    public var statusCode: Int? { (response as? HTTPURLResponse)?.statusCode }
    /// Task metrics collected for the request.
    public var metrics: URLSessionTaskMetrics?

    /// Initializes the request.
    public init(value: T, data: Data, request: URLRequest, response: URLResponse, metrics: URLSessionTaskMetrics? = nil) {
        self.value = value
        self.data = data
        self.request = request
        self.response = response
        self.metrics = metrics
    }

    func map<U>(_ closure: (T) -> U) -> Response<U> {
        Response<U>(value: closure(value), data: data, request: request, response: response, metrics: metrics)
    }
}

extension Response: @unchecked Sendable where T: Sendable {}