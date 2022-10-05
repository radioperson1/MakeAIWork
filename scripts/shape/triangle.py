import math

class shape:
    def __init__(self, width, height):
        self.width = width
        self.height = height

class Triangle(shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return round(0.5 * self.width * self.height * math.pi)
