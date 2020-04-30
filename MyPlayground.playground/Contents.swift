import Foundation

class VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
    
    init(name: String, amount: Int, price: Double){
        self.name = name
        self.amount = amount
        self.price = price
    }
}

//TODO: Definir os erros

enum VendingMachineError: Error{
    case productNotFound
    case productUnavailable
    case insufficientFunds
    case productStuck
    case excessiveFunds
}

extension VendingMachineError: LocalizedError{
    var errorDescription: String?{
        switch  self{
        case .productNotFound:
            return "nao tem produto aqui"
        case .productUnavailable:
            return "acabou isso ai"
        case .productStuck:
            return "o seu produto ficou preso"
        case .insufficientFunds:
            return "ta faltando dinheiro nisso aí"
        case .excessiveFunds:
            return "sobrou dinheiro aí"
        }
    }
}

class VendingMachine {
    private var estoque: [VendingMachineProduct]
    private var money: Double
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
        self.money = 0
        
    }
     
    func getProduct(named name: String, with money: Double) throws {
        //TODO: receber o dinheiro e salvar em uma variável
        self.money += money
        
        //TODO: achar o produto que o cliente quer
        let produtoOptional = estoque.first { (produto) -> Bool in
            return produto.name == name
        }
        guard let produto = produtoOptional else { throw VendingMachineError.productNotFound }
        
        //TODO: ver se ainda tem esse produto
        guard produto.amount > 0 else {throw VendingMachineError.productUnavailable}
        
        
        //TODO: ver se o dinheiro é o suficiente pro produto
        guard produto.price <= self.money else { throw VendingMachineError.insufficientFunds }
        
        //TODO: entregar o produto
        self.money -= produto.price
        if Int.random(in: 0...100) < 10 { throw VendingMachineError.productStuck }
        
        //Verificar se sobrou dinheiro
        guard produto.price >= self.money else { throw VendingMachineError.excessiveFunds }
        
    }
    
    func getTroco(named name: String, with money: Double) throws {
        //TODO: devolver o dinheiro que não foi gasto
        
//        self.money += money
//
//        let produtoOp = estoque.first { (produto) -> Bool in
//            return produto.name == name
//        }
//        guard let produto = produtoOp else { throw VendingMachineError.productNotFound }
//
        
        
        //Subtração da conta total com o que foi pago
        
    }
}

let vendingMachine = VendingMachine(products: [
    VendingMachineProduct(name: "Carregador de Iphone", amount: 5, price: 150.00),
    VendingMachineProduct(name: "Cebolitos", amount: 2, price: 7.00),
    VendingMachineProduct(name: "Umbrella", amount: 5, price: 150.00),
    VendingMachineProduct(name: "Trator", amount: 5, price: 150.00)
])

do{
    try vendingMachine.getProduct(named: "Umbrella", with: 2000.00)
    try vendingMachine.getProduct(named: "Cebolitos", with: 7.00)
    print("deu bom")
    try vendingMachine.getProduct(named: "Trator", with: 1000)
} catch VendingMachineError.productStuck{
    print("Pedimos desculpas, mas houve um problema, o seu produto ficou preso")
} catch VendingMachineError.excessiveFunds{
    print("Sobrou dinheiro")
} catch{
    print(error.localizedDescription)
}

