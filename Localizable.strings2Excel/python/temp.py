import re

from datetime import datetime

from StringsFileUtil import StringsFileUtil
from XmlFileUtil import XmlFileUtil
from XlsOperationUtil import XlsOperationUtil


def compareiOSandAndroid(iosFile, androidFile):
    (ikeys, ivalues) = StringsFileUtil.getKeysAndValues(iosFile)
    (akeys, avalues) = XmlFileUtil.getKeysAndValues(androidFile)

    commonIOSKeys = []
    commonAndroidKeys = []
    commonValues = []

    onlyAndroidKeys = []
    onlyAndroidValues = []

    onlyIOSKeys = []
    onlyIOSValues = []

    for index, key in enumerate(ikeys):
        if ivalues[index] in avalues:
            commonIOSKeys.append(key)
            commonValues.append(ivalues[index])
            commonAndroidKeys.append(akeys[avalues.index(ivalues[index])])
        else:
            onlyIOSKeys.append(key)
            onlyIOSValues.append(ivalues[index])
    for index, key in enumerate(akeys):
        if key not in commonAndroidKeys:
            onlyAndroidKeys.append(key)
            onlyAndroidValues.append(avalues[index])

    XlsOperationUtil.writeToFile("/output", "common.xlsx", ["iOS-Key", "android-Key", "commonValues"], [commonIOSKeys, commonAndroidKeys, commonValues])
    XlsOperationUtil.writeToFile("/output", "ios.xlsx", ["Key", "Value"], [onlyIOSKeys, onlyIOSValues])
    XlsOperationUtil.writeToFile("/output", "android.xlsx", ["Key", "Value"], [onlyAndroidKeys, onlyAndroidValues])
    # XlsOperationUtil.writeToFile("/output", "difference.xlsx", ["iOS-Key", "iOS-Value", "android-Key", "android-Value"], [onlyIOSKeys, onlyIOSValues, onlyAndroidKeys, onlyAndroidValues])


def main():
    iosfile = "/Users/yyg/Documents/ukelink/fork/yyg/simbox-app/platforms/iOS/SIMBOX+/Resources/zh-Hans.lproj/Localizable.strings"
    androidfile = "/Users/yyg/Documents/ukelink/fork/yyg/android/simbox-app/platforms/android/app/src/main/res/values-zh-rCN/strings.xml"
    compareiOSandAndroid(iosfile, androidfile)


main()
