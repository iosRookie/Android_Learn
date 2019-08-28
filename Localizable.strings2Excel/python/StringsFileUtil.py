#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
from Log import Log
import codecs
import re
import io


class StringsFileUtil:
    'iOS Localizable.strings file util'

    @staticmethod
    def writeToFile(keys, values, directory, name, additional):
        if not os.path.exists(directory):
            os.makedirs(directory)

        Log.info("Creating iOS file:" + directory + name)

        fo = open(directory + "/" + name, "wb")

        for x in range(len(keys)):
            if values[x] is None or values[x] == '':
                Log.error("Key:" + keys[x] +
                          "\'s value is None. Index:" + str(x + 1))
                continue

            key = keys[x].strip()
            value = values[x]
            content = "\"" + key + "\" " + "= " + "\"" + value + "\";\n"
            fo.write(content)

        if additional is not None:
            fo.write(additional)

        fo.close()

    @staticmethod
    def getKeysAndValues(path):
        if path is None:
            Log.error('file path is None')
            return
        tuples = []
        # 1.Read localizable.strings
        try:
            file = codecs.open(path, 'r', encoding='utf-8')
            for line in file:
                pattern = re.compile('\".*\";')
                value = pattern.search(line)
                if value is not None:
                    result = re.findall(r"\"(.*)\"\s*=\s*\"(.*)\";", value.string)
                    if len(result) > 0:
                        tuples.append(result[0])
            file.close()
        except UnicodeDecodeError:
            print("got unicode error with utf-8 , trying different encoding")

        keys = []
        values = []
        for x in tuples:
            if len(x) >= 2:
                keys.append(x[0])
                values.append(x[1])
        return keys, values
