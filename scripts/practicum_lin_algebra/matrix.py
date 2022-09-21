class Matrix:

    def __init__(self, vectorList):
        self.vectorList = vectorList

    def __add__(self, matrix2):
        vectorList2 = matrix2.vectorList
        vectorList3 = self.addVectors(self.vectorList, vectorList2)
        return Matrix(vectorList3)

    def addVectors(selfs, v1, v2):
        if len(v1) != len(v2):
            return None
        else:
            v3 = [sum(tup) for tup in zip(v1, v2)]
            return (v3)

vectorList1 = ([1, 2, 3])
vectorList2 = ([4, 5, 6])
matrix1 = Matrix(vectorList1)
matrix2 = Matrix(vectorList2)
matrix3 = matrix1 + matrix2
print(matrix3.vectorList)
