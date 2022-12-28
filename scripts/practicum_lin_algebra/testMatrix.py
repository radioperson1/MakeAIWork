import unittest
from employee import Employee

class TestMatrix(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print('setupClass')

    def setUp(self):
        print('setUp')
        self.matrix1
        vectorList1 = ([1, 2, 3], [4, 5, 6])
        vectorList2 = ([1, 1, 1], [1, 1, 1])

    def test_add(self):
        print('test_add')
        # self.assertEqual(self.emp_1.email, 'Corey.Schafer@email.com')

if __name__ == '__main__':
    unittest.main()
