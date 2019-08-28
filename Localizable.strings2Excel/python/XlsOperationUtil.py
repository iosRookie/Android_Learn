import os

import xlsxwriter
import xlrd

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


