import UIKit
import Darwin

/*Задача 1 (основная)
ВЫ - главный архитектор в команде разработчиков. Ваша задача - разработать программное обеспечение (ПО) для дилерских центров по продаже автомобилей. Ваша цель - создать гибкое ПО. Что это значит? Ваше ПО должно подходить для любой марки авто, должно быть расширяемым и масштабируемым в дальнейшем, чтобы ваша компания могла выпускать обновления. Задача разделена на 4 части, в каждой из них нужно самостоятельно подумать, какой тип данных передать каждому свойству для комфортной работы, а также по необходимости добавить вспомогательные методы.
Часть 1.
Для начала нужно описать машину минимальным набором параметров, используя протокол.
-Алгоритм выполнения
1.Создайте протокол 'Car'
2.Добавьте в него свойства:
  -'model' (только для чтения): марка
  -'color' (только для чтения): цвет
  -'buildDate' (только для чтения): дата выпуска
  -'price' (чтение и запись): цена авто
  -'accessories' (чтение и запись): дополнительное оборудование (тонировка, сингнализация, спортивные диски)
  -'isServiced' (чтение и запись): сделана ли предпродажная подготовка. Обычно ее делают в дилерских центрах перед постановкой машины в салон.*/
enum Color: String, CaseIterable {
    case white
    case black
    case blue
    case red
    case yellow
    case green
}

enum ModelCar:String {
    case bmw3, bmw1, bmw2
    case audi1, audi2, audi3
    case honda1, honda2, honda3
    case lexus1, lexus2, lexus3
    case volvo1, volvo2, volvo3
}
protocol CarProtocol {
   // var model: { get }
    var model: ModelCar { get } //static, privat
    var color: Color { get } // enum
    var buildDate: Int { get } //Date int
    var price: Int { get set }
    var accessories: Set <String> { get set }//(toner:Bool, alarm:Bool, sportDiscs:Bool) { get set }
    var isServised: Bool { get set }
}
/*Часть 2.
По аналогии с протоколом 'Car', нужно описать дилерский центр минимальным набором свойств и методов, используя протокол.
-Алгоритм выполнения
1.Создайте протокол 'Dealership'
2.Добавьте свойства:
  -'name' (только для чтения): название дилерского центра (назвать по марке машины для упрощения)
  -'showroomCapacity' (только для чтения): максимальная вместимость автосалона по количеству машин.
  -'stockCars' (массив, чтение и запись): машины, находящиеся на парковке склада. Представим, что парковка не имеет лимита по количеству машин.
  -'showroomCars' (массив, чтение и запись): машины, находящиеся в автосалоне.
  -'cars' (массив, чтение и запись): хранит список всех машин в наличии.
3.Добавьте методы:
  -'offerAccesories(_ :)': принимает массив акксесуаров в качестве параметра. Метод предлагает клиенту купить доп. оборудование.
  -'presaleService(_ :)': принимает машину в качестве параметра. Метод отправляет машину на предпродажную подготовку.
  -'addToShowroom(_ :)': также принимает машину в качестве параметра. Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
  -'sellCar(_ :)': также принимает машину в качестве параметра. Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка. Также, если у машины отсутсвует доп. оборудование, нужно предложить клиенту его купить. (давайте представим, что клиент всегда соглашается и покупает :) )
  -'orderCar()': не принимает и не возвращает параметры. Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
Обратите внимание! Каждый метод должен выводить в консоль информацию о машине и выполненном действии с ней.*/
protocol Dealership {
    var name: String { get }
    var showroomCapacity: Int { get }
    var stockCars: [Cars] { get set }
    var showroomCars: [Cars] { get set }
    var allCars: [Cars] { get }
    func offerAccessories(forCar: inout Cars)
    //func offerAccessories(carAccessories: inout CarProtocol)
    func presaleService(car: inout Cars) //inout
    func addToShowroom(car: inout Cars) //inout
    func sellCar(car: inout Cars) //inout
    func orderCar()
}
/*Часть 3.
Настало время добавить классы и структуры, реализующие созданные ранее протоколы.
-Алгоритм выполнения
1.Используя структуры, создайте несколько машин разных марок (например BMW, Honda, Audi, Lexus, Volvo). Все они должны реализовать протокол 'Car'.
2.Используя классы, создайте пять различных дилерских центров (например BMW, Honda, Audi, Lexus, Volvo). Все они должны реализовать протокол 'Dealership'. Каждому дилерскому центру добавьте машин на парковку и в автосалон (используйте те машины, которые создали ранее).
3.Создайте массив, положите в него созданные дилерские центры. Пройдитесь по нему циклом и выведите в консоль слоган для каждого дилеского центра (слоган можно загуглить).
---Обратите внимание! Используйте конструкцию приведения типа данных для решения этой задачи.*/

struct Cars: CarProtocol, Equatable {
    
    var model: ModelCar
    var color: Color
    var buildDate: Int
    var price: Int
    public var accessories:Set <String>
    var isServised: Bool
}
var bMW1 = Cars(model: .bmw1, color: .blue, buildDate: 2020, price: 5000, accessories: ["toner", "sportDiscs"],  isServised: false)
var bMW2 = Cars(model: .bmw2, color: .green, buildDate: 2021, price: 6200, accessories: ["sportDiscs"],  isServised: true)
var bMW3 = Cars(model: .bmw3, color: .black, buildDate: 2022, price: 6900, accessories: ["sportDiscs"],  isServised: false)


var audi1 = Cars(model: .audi1, color: .red, buildDate: 2022, price: 7000, accessories: ["sportDiscs"], isServised: true)
var audi2 = Cars(model: .audi2, color: .white, buildDate: 2021, price: 6700, accessories: ["sportDiscs", "alarm"], isServised: false)

var volvo1 = Cars(model: .volvo1, color: .yellow, buildDate: 2021, price: 6500, accessories: ["alarm", "toner"], isServised: false)
var volvo2 = Cars(model: .volvo2, color: .white, buildDate: 2022, price: 8000, accessories: [], isServised: true
)
var honda1: CarProtocol = Cars(model: .honda1, color: .yellow, buildDate: 2022, price: 5500, accessories: [], isServised: false)
var honda2: CarProtocol = Cars(model: .honda2, color: .black, buildDate: 2020, price: 4500, accessories: ["sportDiscs"], isServised: true)

var lexus1: CarProtocol = Cars(model: .lexus1, color: .black, buildDate: 2021, price: 7500, accessories: ["alarm"], isServised: true)
var lexus2: CarProtocol = Cars(model: .lexus2, color: .red, buildDate: 2022, price: 9000, accessories: ["alarm", "toner"], isServised: false)

bMW1.price = 6000
print(bMW1.price)

//MARK: - Dealers
class BMwDealers: Dealership {
    
    var stockCars: [Cars] = []
    var showroomCars: [Cars] = []
    var allCars: [Cars] { stockCars + showroomCars }
    static var priceNewCar: Int = 3000
    var name: String
    var showroomCapacity: Int
    let slogan = "BMW waiting for you!"
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }

    func offerAccessories(forCar: inout Cars) { //принимает массив акксесуаров в качестве параметра. Метод предлагает клиентy             купить доп. оборудование.
        let newAccessories:Set = ["toner", "alarm", "sportDiscs"]
        forCar.accessories = forCar.accessories.union(newAccessories)
        print("This car \(forCar.model) has full pack of acessories - toner, alarm system and sport discs!")
    }

    func presaleService(car: inout Cars) { //принимает машину в качестве параметра. Метод отправляет машину на предпродажную подготовку.
        if car.isServised {
            print("Car \(car.model) was servised before")
        } else {
            car.isServised = true
            print("For car \(car.model) just was made presale service!")
        }
    }

    func addToShowroom(car: inout Cars) { //также принимает машину в качестве параметра. Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
        if showroomCapacity > showroomCars.count {
            if stockCars.contains(car) {
                
                presaleService(car: &car)
                showroomCars.append(car)
                print("car \(car.model) has a presale service, moved from stock to showroom parking")
                if let index = stockCars.firstIndex(of: car) { stockCars.remove(at: index) }
            } else {
                print("We don't have this car \(car.model) at all")
            }
        } else {
            print("Showroom can contain just \(showroomCapacity) cars. It's fool")
        }
    }

    func sellCar(car: inout Cars) { //также принимает машину в качестве параметра. Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка. Также, если у машины отсутсвует доп. оборудование, нужно предложить клиенту его купить. (давайте представим, что клиент всегда соглашается и покупает :) )
                                            //а если здесь входящим параметром задать элемент массива showroom cars?
        if showroomCars.contains(car) {
            if car.isServised {
                for index in 0...showroomCars.count - 1 {
                    if car == showroomCars[index] {
                        showroomCars.remove(at: index)
                    }
                }
                offerAccessories(forCar: &car)
                print("car \(car.model) sold with full accessories pack by price \(car.price)")
            
            } else {
                print("Car \(car.model) need presale service before sale")
            }
        } else {
            print("check this car \(car.model) in stock. it is not in showroom")
        }
    }

    func orderCar() { // не принимает и не возвращает параметры. Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
        let arrayBMW: [ModelCar] = [.bmw1, .bmw2, .bmw3]
        let newCar = Cars(model: arrayBMW.randomElement()!, color: Color.allCases.randomElement()!, buildDate: 2022, price: BMwDealers.priceNewCar, accessories: [], isServised: true)
        print("New car \(newCar.model) just arrived in stock, price \(newCar.price), color \(newCar.color), serviced, without accessories")
        BMwDealers.priceNewCar += 500
    }
}



var dealerBMW: Dealership = BMwDealers(name: "BMW", showroomCapacity: 7)
print("1th func--------------")
dealerBMW.orderCar()
dealerBMW.stockCars.append(bMW1)
dealerBMW.stockCars.append(bMW2)
print(dealerBMW.stockCars.count)
print("2th func--------------")
print(bMW1.accessories)
dealerBMW.offerAccessories(forCar: &bMW1)
print(bMW1.accessories)
print("3th func--------------")
print(bMW1.isServised)
dealerBMW.presaleService(car: &bMW1)
print(bMW1.isServised)
dealerBMW.presaleService(car: &bMW2)
print("4th func--------------")
print(dealerBMW.showroomCars.count)
print(dealerBMW.stockCars.count)
dealerBMW.addToShowroom(car: &bMW1)
dealerBMW.addToShowroom(car: &bMW2)
print(dealerBMW.showroomCars.count)
print(dealerBMW.stockCars.count) //не удалил из стока
print("5th func--------------")
dealerBMW.sellCar(car: &bMW2)
print(dealerBMW.showroomCars.count)
print(dealerBMW.stockCars.count)
print(dealerBMW.allCars.count)
dealerBMW.stockCars.append(bMW3)
print(dealerBMW.allCars.count)

class AudiDealers: Dealership {
    
    var stockCars: [Cars] = []
    var showroomCars: [Cars] = []
    var allCars: [Cars] { stockCars + showroomCars }
    static var priceNewCar: Int = 3500
    var name: String
    var showroomCapacity: Int
    let slogan = "Audi say Salut!"
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }

    func offerAccessories(forCar: inout Cars) {
        let newAccessories:Set = ["toner", "alarm", "sportDiscs"]
        forCar.accessories = forCar.accessories.union(newAccessories)
        print("This car \(forCar.model) has full pack of acessories - toner, alarm system and sport discs!")
    }

    func presaleService(car: inout Cars) {
        if car.isServised {
            print("Car \(car.model) was servised before")
        } else {
            car.isServised = true
            print("For car \(car.model) just was made presale service!")
        }
    }

    func addToShowroom(car: inout Cars) {
        if showroomCapacity > showroomCars.count {
            if stockCars.contains(car) {
                
                presaleService(car: &car)
                showroomCars.append(car)
                print("car \(car.model) has a presale service, moved from stock to showroom parking")
                if let index = stockCars.firstIndex(of: car) { stockCars.remove(at: index) }
            } else {
                print("We don't have this car \(car.model) at all")
            }
        } else {
            print("Showroom can contain just \(showroomCapacity) cars. It's fool")
        }
    }

    func sellCar(car: inout Cars) {
        if showroomCars.contains(car) {
            if car.isServised {
                for index in 0...showroomCars.count - 1 {
                    if car == showroomCars[index] {
                        showroomCars.remove(at: index)
                    }
                }
                offerAccessories(forCar: &car)
                print("car \(car.model) sold with full accessories pack by price \(car.price)")
            
            } else {
                print("Car \(car.model) need presale service before sale")
            }
        } else {
            print("check this car \(car.model) in stock. it is not in showroom")
        }
    }

    func orderCar() {
        let arrayAudi: [ModelCar] = [.audi1, .audi2, .audi3]
        let newCar = Cars(model: arrayAudi.randomElement()!, color: Color.allCases.randomElement()!, buildDate: 2022, price: AudiDealers.priceNewCar, accessories: [], isServised: true)
        print("New car \(newCar.model) just arrived in stock, price \(newCar.price), color \(newCar.color), serviced, without accessories")
        AudiDealers.priceNewCar += 500
    }
}

print("AUDI Dealer----------------")
var dealerAudi: Dealership = AudiDealers(name: "Audi", showroomCapacity: 4)
dealerAudi.addToShowroom(car: &audi1)
dealerAudi.orderCar()
dealerAudi.orderCar()
dealerAudi.stockCars.append(audi1)
dealerAudi.stockCars.append(audi2)
print(dealerAudi.showroomCars.count)
print(dealerAudi.stockCars.count)
print(dealerAudi.allCars.count)
dealerAudi.addToShowroom(car: &audi1)
print("------------")
print(dealerAudi.stockCars.count)
print(dealerAudi.showroomCars.count)
if dealerAudi.stockCars.isEmpty == false { dealerAudi.showroomCars.append(dealerAudi.stockCars.removeFirst()) }
print(dealerAudi.showroomCars.count)
print(dealerAudi.stockCars.count)
if dealerAudi.stockCars.isEmpty == false { dealerAudi.showroomCars.append(dealerAudi.stockCars.removeFirst()) }

class VolvoDealers: Dealership {
    
    var stockCars: [Cars] = []
    var showroomCars: [Cars] = []
    var allCars: [Cars] { stockCars + showroomCars }
    static var priceNewCar: Int = 4000
    var name: String
    var showroomCapacity: Int
    let slogan = "Volvo inviting you!"
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }

    func offerAccessories(forCar: inout Cars) {
        let newAccessories:Set = ["toner", "alarm", "sportDiscs"]
        forCar.accessories = forCar.accessories.union(newAccessories)
        print("This car \(forCar.model) has full pack of acessories - toner, alarm system and sport discs!")
    }

    func presaleService(car: inout Cars) {
        if car.isServised {
            print("Car \(car.model) was servised before")
        } else {
            car.isServised = true
            print("For car \(car.model) just was made presale service!")
        }
    }

    func addToShowroom(car: inout Cars) {
        if showroomCapacity > showroomCars.count {
            if stockCars.contains(car) {
                
                presaleService(car: &car)
                showroomCars.append(car)
                print("car \(car.model) has a presale service, moved from stock to showroom parking")
                if let index = stockCars.firstIndex(of: car) { stockCars.remove(at: index) }
            } else {
                print("We don't have this car \(car.model) at all")
            }
        } else {
            print("Showroom can contain just \(showroomCapacity) cars. It's fool")
        }
    }

    func sellCar(car: inout Cars) {
        if showroomCars.contains(car) {
            if car.isServised {
                for index in 0...showroomCars.count - 1 {
                    if car == showroomCars[index] {
                        showroomCars.remove(at: index)
                    }
                }
                offerAccessories(forCar: &car)
                print("car \(car.model) sold with full accessories pack by price \(car.price)")
            
            } else {
                print("Car \(car.model) need presale service before sale")
            }
        } else {
            print("check this car \(car.model) in stock. it is not in showroom")
        }
    }

    func orderCar() {
        let arrayVolvo: [ModelCar] = [.volvo1, .volvo2, .volvo3]
        let newCar = Cars(model: arrayVolvo.randomElement()!, color: Color.allCases.randomElement()!, buildDate: 2022, price: VolvoDealers.priceNewCar, accessories: [], isServised: true)
        print("New car \(newCar.model) just arrived in stock, price \(newCar.price), color \(newCar.color), serviced, without accessories")
        VolvoDealers.priceNewCar += 500
    }
}
var volvoDealer:Dealership = VolvoDealers(name: "Volvo", showroomCapacity: 5)

class HondaDealers: Dealership {
    
    var stockCars: [Cars] = []
    var showroomCars: [Cars] = []
    var allCars: [Cars] { stockCars + showroomCars }
    static var priceNewCar: Int = 4500
    var name: String
    var showroomCapacity: Int
    let slogan = "Honda welcoming you!"
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }

    func offerAccessories(forCar: inout Cars) {
        let newAccessories:Set = ["toner", "alarm", "sportDiscs"]
        forCar.accessories = forCar.accessories.union(newAccessories)
        print("This car \(forCar.model) has full pack of acessories - toner, alarm system and sport discs!")
    }

    func presaleService(car: inout Cars) {
        if car.isServised {
            print("Car \(car.model) was servised before")
        } else {
            car.isServised = true
            print("For car \(car.model) just was made presale service!")
        }
    }

    func addToShowroom(car: inout Cars) {
        if showroomCapacity > showroomCars.count {
            if stockCars.contains(car) {
                
                presaleService(car: &car)
                showroomCars.append(car)
                print("car \(car.model) has a presale service, moved from stock to showroom parking")
                if let index = stockCars.firstIndex(of: car) { stockCars.remove(at: index) }
            } else {
                print("We don't have this car \(car.model) at all")
            }
        } else {
            print("Showroom can contain just \(showroomCapacity) cars. It's fool")
        }
    }

    func sellCar(car: inout Cars) {
        if showroomCars.contains(car) {
            if car.isServised {
                for index in 0...showroomCars.count - 1 {
                    if car == showroomCars[index] {
                        showroomCars.remove(at: index)
                    }
                }
                offerAccessories(forCar: &car)
                print("car \(car.model) sold with full accessories pack by price \(car.price)")
            
            } else {
                print("Car \(car.model) need presale service before sale")
            }
        } else {
            print("check this car \(car.model) in stock. it is not in showroom")
        }
    }

    func orderCar() {
        let arrayHonda: [ModelCar] = [.honda1, .honda2, .honda3]
        let newCar = Cars(model: arrayHonda.randomElement()!, color: Color.allCases.randomElement()!, buildDate: 2022, price: HondaDealers.priceNewCar, accessories: [], isServised: true)
        print("New car \(newCar.model) just arrived in stock, price \(newCar.price), color \(newCar.color), serviced, without accessories")
        HondaDealers.priceNewCar += 500
    }
}

class LexusDealers: Dealership {
    
    var stockCars: [Cars] = []
    var showroomCars: [Cars] = []
    var allCars: [Cars] { stockCars + showroomCars }
    static var priceNewCar: Int = 5000
    var name: String
    var showroomCapacity: Int
    let slogan = "Lexus greating you!"
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }

    func offerAccessories(forCar: inout Cars) {
        let newAccessories:Set = ["toner", "alarm", "sportDiscs"]
        forCar.accessories = forCar.accessories.union(newAccessories)
        print("This car \(forCar.model) has full pack of acessories - toner, alarm system and sport discs!")
    }

    func presaleService(car: inout Cars) {
        if car.isServised {
            print("Car \(car.model) was servised before")
        } else {
            car.isServised = true
            print("For car \(car.model) just was made presale service!")
        }
    }

    func addToShowroom(car: inout Cars) {
        if showroomCapacity > showroomCars.count {
            if stockCars.contains(car) {
                
                presaleService(car: &car)
                showroomCars.append(car)
                print("car \(car.model) has a presale service, moved from stock to showroom parking")
                if let index = stockCars.firstIndex(of: car) { stockCars.remove(at: index) }
            } else {
                print("We don't have this car \(car.model) at all")
            }
        } else {
            print("Showroom can contain just \(showroomCapacity) cars. It's fool")
        }
    }

    func sellCar(car: inout Cars) {
        if showroomCars.contains(car) {
            if car.isServised {
                for index in 0...showroomCars.count - 1 {
                    if car == showroomCars[index] {
                        showroomCars.remove(at: index)
                    }
                }
                offerAccessories(forCar: &car)
                print("car \(car.model) sold with full accessories pack by price \(car.price)")
            
            } else {
                print("Car \(car.model) need presale service before sale")
            }
        } else {
            print("check this car \(car.model) in stock. it is not in showroom")
        }
    }

    func orderCar() {
        let arrayLexus: [ModelCar] = [.lexus1, .lexus2, .lexus3]
        let newCar = Cars(model: arrayLexus.randomElement()!, color: Color.allCases.randomElement()!, buildDate: 2022, price: LexusDealers.priceNewCar, accessories: [], isServised: true)
        print("New car \(newCar.model) just arrived in stock, price \(newCar.price), color \(newCar.color), serviced, without accessories")
        LexusDealers.priceNewCar += 500
    }
}

var dealerVolvo: Dealership = VolvoDealers(name: "Volvo", showroomCapacity: 5)
var dealerHonda: Dealership = HondaDealers(name: "Honda", showroomCapacity: 4)
var dealerLexus: Dealership = LexusDealers(name: "Lexus", showroomCapacity: 3)
//3.Создайте массив, положите в него созданные дилерские центры. Пройдитесь по нему циклом и выведите в консоль слоган для каждого дилеского центра (слоган можно загуглить).
var arrayOfDealers:[Dealership] = [dealerBMW as! BMwDealers , dealerAudi as! AudiDealers, dealerHonda as! HondaDealers, dealerLexus as! LexusDealers, dealerVolvo as! VolvoDealers]

print("Slogan---------------")
arrayOfDealers.forEach {
    if let castingDealer = $0 as? BMwDealers {
        print(castingDealer.slogan)
    }
    if let castingDealer = $0 as? AudiDealers {
        print(castingDealer.slogan)
    }
    if let castingDealer = $0 as? HondaDealers {
        print(castingDealer.slogan)
    }
    if let castingDealer = $0 as? LexusDealers {
        print(castingDealer.slogan)
    }
    if let castingDealer = $0 as? VolvoDealers {
        print(castingDealer.slogan)
    }
}

/*Часть 4.
Работа с расширениями. Нам нужно добавить спецпредложение для "прошлогодних" машин.
-Алгоритм выполнения
1.Создайте протокол SpecialOffer.
2.Добавьте методы:
  -'addEmergencyPack()': не принимает никаких параметров. Метод добавляет аптечку и огнетушитель к доп. оборудованию машины.
  -'makeSpecialOffer()': не принимает никаких параметров. Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего, нужно сделать скидку 15%, а также добавить аптечку и огнетушитель.
3.Используя расширение, реализуйте протокол 'SpecialOffer' для любых трех дилерских центров.
4.Проверьте все машины в дилерском центре (склад + автосалон), возможно они нуждаются в специальном предложении. Если есть машины со скидкой на складе, нужно перегнать их в автосалон.*/
protocol SpecialOffer {
    func addEmergencyPack() // с параметрами
    func makeSpecialOffer() //didset willset // без параметров
}

extension BMwDealers: SpecialOffer {

    func addEmergencyPack() {
        let specialPack:Set = ["First Aid Kit", "Extinguisher"]
        for (index, car) in stockCars.enumerated() {
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            stockCars[index] = newCar
        }
        for (index, car) in showroomCars.enumerated() {
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            showroomCars[index] = newCar
        }
        print("Now all cars have extra pack of accessories - First Aid Kit + Extinguisher")
    }
            
    func makeSpecialOffer() {   //не принимает никаких параметров. Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего, нужно сделать скидку 15%, а также добавить аптечку и огнетушитель. Проверьте все машины в дилерском центре (склад + автосалон), возможно они нуждаются в специальном предложении. Если есть машины со скидкой на складе, нужно перегнать их в автосалон.
        let specialPack:Set = ["First Aid Kit", "Extinguisher"]
        for (index, car) in stockCars.enumerated() {
            if car.buildDate == 2022 {
                continue
            }
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            newCar.price = Int(Double(car.price) * 0.85)
            showroomCars.append(newCar)
            //stockCars[index] = newCar
            print("car \(car.model) old price \(car.price) -> new price \(newCar.price) moved to showroom from stock")
            stockCars.remove(at: index)
        }
    }
}

print("part 4 ----------------------")
var dealerBMW2 = BMwDealers(name: "BMW2", showroomCapacity: 10)
dealerBMW2.orderCar()
dealerBMW2.orderCar()
dealerBMW2.stockCars.append(bMW1)
dealerBMW2.stockCars.append(bMW2)
dealerBMW2.stockCars.append(bMW3)
dealerBMW2.addToShowroom(car: &bMW2)
dealerBMW2.makeSpecialOffer()
    


extension AudiDealers: SpecialOffer {

    func addEmergencyPack() {
        let specialPack:Set = ["First Aid Kit", "Extinguisher"]
        for (index, car) in stockCars.enumerated() {
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            stockCars[index] = newCar
        }
        for (index, car) in showroomCars.enumerated() {
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            showroomCars[index] = newCar
        }
        print("Now all cars have extra pack of accessories - First Aid Kit + Extinguisher")
    }
            
    func makeSpecialOffer() {
        let specialPack:Set = ["First Aid Kit", "Extinguisher"]
        for (index, car) in stockCars.enumerated() {
            if car.buildDate == 2022 {
                continue
            }
            var newCar = car
            newCar.accessories = car.accessories.union(specialPack)
            newCar.price = Int(Double(car.price) * 0.85)
            showroomCars.append(newCar)
            //stockCars[index] = newCar
            print("car \(car.model) old price \(car.price) -> new price \(newCar.price) moved to showroom from stock")
            stockCars.remove(at: index)
        }
    }
}


    
