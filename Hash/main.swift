import Foundation
import Collections
import DequeModule

struct bucket<Key: Hashable, Value> {
    let key: Key
    var value: Value
}

struct HashTable<Key: Hashable, Value> {
    private var buckets: [bucket<Key, Value>?]
    
    init(capacity: Int) {
        self.buckets = Array(repeating: nil, count: capacity)
    }
    
    func hasher(_ key: Key) -> Int { //algoritmo pra pegar o hash da chave
        var hashValue = 0
        let stringKey = "\(key)"
        
        for scalar in stringKey.unicodeScalars {
            hashValue += Int(scalar.value)
        }
        
        return hashValue % buckets.count
    }
    
    mutating func insert(key: Key, value: Value) {
        let index = hasher(key)
        
        if let existingBucket = buckets[index] {
            if existingBucket.key == key {
                buckets[index]?.value = value
            } else { // tem que ajeitar isso ainda. n tem suporte pra colisão
                print("Colisão: \(index),  \(key)")
            }
        } else {
            buckets[index] = bucket(key: key, value: value)
            return print("Added \(key) in index \(index)")
        }
    }
    
    func list(getValueIn: Key? = nil) -> String { //só pra ver oq tem na tabela/achar valor
        if let key = getValueIn {
            let index = hasher(key)
            if let value = buckets[index]?.value {
                return "Value in \(key) is \(value)"
            } else {
                return "Bad Key: \(key)"
            }
        }
        return "\(buckets)"
    }
}

var Dictionary = HashTable<String, String>(capacity: 10)
Dictionary.insert(key: "name", value: "cim borg")
Dictionary.insert(key: "animal", value: "dog")

print(Dictionary.list())
print(Dictionary.list(getValueIn: "name"))
print(Dictionary.list(getValueIn: "animal"))
print(Dictionary.list(getValueIn: "bleh"))
