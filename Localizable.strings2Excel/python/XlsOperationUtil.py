import codecs
import re

import xlsxwriter

from Log import Log


class XlsOperationUtil:
    def __init__(self):
        pass

    @staticmethod
    def writeToFile(filePath, xlsName, titles, values):
        if filePath is None:
            Log.error('write file path is None')
            return
        # if not os.path.exists(filePath):
            # os.makedirs(filePath)
        workbook = xlsxwriter.Workbook(xlsName)
        titleBold = workbook.add_format({
            'bold': True,
            'border': 1,
            'align': 'left',
            'valign': 'vcenter',
            'fg_color': '#00FF00',
        })
        worksheet = workbook.add_worksheet()

        startLine = 0
        if titles:
            startLine = 1
            for index in range(len(titles)):
                worksheet.write(0, index, titles[index], titleBold)

        for lindex in range(len(values)):
            if isinstance(values[lindex], list):
                for cindex in range(len(values[lindex])):
                    worksheet.write(cindex + startLine, lindex, values[lindex][cindex])
        workbook.close()

    @staticmethod
    def getIOSKeysAndValues(path):
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


