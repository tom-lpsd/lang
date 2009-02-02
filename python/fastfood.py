#!/usr/bin/python

class Lunch:
    def __init__(self):
        self.cus = Customer()
        self.emp = Employee()

    def order(self, foodName):
        self.cus.placeOrder(foodName, self.emp)

    def result(self):
        self.cus.printFood()

class Customer:
    def __init__(self):
        self.foods = []

    def placeOrder(self, foodName, employee):
        self.foods.append(employee.takeOrder(foodName))

    def printFood(self):
        for food in self.foods:
            print food.name

class Employee:
    def takeOrder(self, foodName):
        return Food(foodName)

class Food:
    def __init__(self, name):
        self.name = name

if __name__ == '__main__':
    store = Lunch()
    store.order('EggToast')
    store.result()
