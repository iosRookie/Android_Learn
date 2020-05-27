//
//  SwiftLogUtil.swift
//  Runner
//
//  Created by yyg on 2020/5/15.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation

func FXLOG_DEBUG(_ format: String = "%@", _ output: Any...) {
//    LogInternal(level: 1, module: "", fileName: String(#file).split(separator:"/").map(String.init).last!, line: #line, funcName: #function, prefix: "Debug", format: format, output: output)
        LogInternal(level: 1, module: "", fileName: "", line: 0, funcName: "", prefix: "Debug", format: format, output: output)
}

func FXLOG_INFO(_ format: String = "%@", _ output: Any...) {
//    LogInternal(level: 2, module: "", fileName: String(#file).split(separator:"/").map(String.init).last!, line: #line, funcName: #function, prefix: "Info", format: format, output: output)
    LogInternal(level: 2, module: "", fileName: "", line: 0, funcName: "", prefix: "Info", format: format, output: output)
}

func FXLOG_WARNING(_ format: String = "%@", _ output: Any...) {
//    LogInternal(level: 3, module: "", fileName: String(#file).split(separator:"/").map(String.init).last!, line: #line, funcName: #function, prefix: "Warning", format: format, output: output)
    LogInternal(level: 3, module: "", fileName: "", line: 0, funcName: "", prefix: "Warning", format: format, output: output)
}

func FXLOG_ERROR(_ format: String = "%@", _ output: Any...) {
//    LogInternal(level: 4, module: "", fileName: String(#file).split(separator:"/").map(String.init).last!, line: #line, funcName: #function, prefix: "Error", format: format, output: output)
    LogInternal(level: 4, module: "", fileName: "", line: 0, funcName: "", prefix: "Error", format: format, output: output)
}

func FXLOG_ALL(_ format: String = "%@", _ output: Any...) {
//    LogInternal(level: 0, module: "", fileName: String(#file).split(separator:"/").map(String.init).last!, line: #line, funcName: #function, prefix: "All", format: format, output: output)
    LogInternal(level: 0, module: "", fileName: "", line: 0, funcName: "", prefix: "All", format: format, output: output)
}

private func LogInternal(level: Int32, module: String?, fileName: String, line: Int, funcName: String, prefix: String?, format: String, output: Any...) {
    NativeLogHelper.log(withLevel: level, moduleName: module!, fileName: fileName, lineNumber: Int32(line), funcName: funcName, message: String.init(format: format, output))
}
