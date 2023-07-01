with open('subfolder/pypackage/file1.txt') as f:
    with open('subfolder/pypackage/file2.txt') as g:
        print(f.read())
        print(g.read())
