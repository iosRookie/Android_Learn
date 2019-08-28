import os


def getAllLocalizableFile(path):
    if len(path) < 1:
        return
    if path.endswith("/"):
        path = path[:-1]
    for _, dirName, _ in os.walk(path):
        lprojDirs = [di for di in dirName if di.endswith(".lproj")]
        for lproj in lprojDirs:
            for _, _, files in os.walk(path + "/" + lproj):
                stringFiles = [file for file in files if file.endswith(".strings")]
                for strFile in stringFiles:
                    print path + "/" + lproj + "/" + strFile


def main():
    getAllLocalizableFile("/Users/yyg/Documents/ukelink/fork/yyg/simbox-app/platforms/iOS/SIMBOX+/Resources/")

main()