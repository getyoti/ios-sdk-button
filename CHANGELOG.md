# ChangeLog

## Version 3.0.0

`GenericError` and `NetworkError` types have been removed and replaced by the following error types: `SetupError`, `ShareRequestError`, `CallbackBackendError`. 

All new error types conform to `LocalizableError` protocol and provide human readable description on which includes the reason that caused it.

### Migration Guide

#### Network Error
`NetworkError` has been included as a distinct error case in `ShareRequestError` and `CallbackBackendError`.

In more detail:
`NetworkError.httpError(Int)` has been replaced with `ShareRequestError.httpRequestError(Int)` and `CallbackBackendError.httpRequestError(Int)`. The associated value of type `Int` provides the status code of the request.

#### Generic Error
`GenericError` included the following cases `nilValue`, `malformedValue(String)` and `unknown(String)`. This type has been completely removed and the different cases are included in the three aforementioned types.