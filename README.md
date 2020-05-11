# Butterfly Systems App

Demo App for Butterfly Systems

<p align="left">
  <img src="https://github.com/jaysalvador/butterfly-systems/blob/master/image/img01.png" width="150" alt="accessibility text">

  <img src="https://github.com/jaysalvador/butterfly-systems/blob/master/image/img02.png" width="150" alt="accessibility text">
</p>

## HTTPClient

Implemented `HttpClient` class to handle HTTP requests to the API and decodes the response to any `Decodable` type object.

All API responses will be conforming to this closure, using the `Result` type:
>  `HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)`

`T` would need to conform to `Decodable` protocol, and errors will be extended using the `HttpError` enum states

## CoreData

Created `Order`, `Item`, `Invoice`, `Receipt` models, with helpers for creating and updating entities. Entity creation autogenerates the `id` based on the current timestamp.

## Client-side App

The app architecture is built using the MVVM pattern and Protocol-oriented programming and Dependency Injection principles.

## Testing

`Butterfly_SystemsTests`
- `testData`: provides simple testing on parsing data and view model functionality
