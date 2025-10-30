import Foundation

struct bucket<Key: Hashable, Value> {
    let key: Key
    var value: Value
}

struct HashTable<Key: Hashable, Value> {
    private var buckets: [[bucket<Key, Value>]]

    private var capacity: Int {
        return buckets.count
    }

    init(capacity: Int) {
        self.buckets = Array(repeating: [], count: capacity)
    }

    func hasher(_ key: Key) -> Int {  //algoritmo pra pegar o hash da chave
        var hashValue = 0
        let stringKey = "\(key)"

        for scalar in stringKey.unicodeScalars {
            hashValue += Int(scalar.value)
        }

        return abs(hashValue % capacity)
    }

    mutating func insert(key: Key, value: Value) {
        let index = hasher(key)

        for (i, existingBucket) in buckets[index].enumerated() {
            if existingBucket.key == key {
                buckets[index][i].value = value
                print("Atualizado \(key) no indice \(index)")
                return
            }
        }
        let newBucket = bucket(key: key, value: value)
        buckets[index].append(newBucket)

        if buckets[index].count > 1 {
            print("Adicionado \(key) no indice \(index) (Colisão resolvida)")
        } else {
            print("Adicionado \(key) no indice \(index)")
        }
    }

    func list(getValueIn: Key? = nil) -> String {  //só pra ver oq tem na tabela/achar valor
        if let key = getValueIn {
            let index = hasher(key)
            let chain = buckets[index]

            for bucket in chain {
                if bucket.key == key {
                    return "Valor na \(key) é \(bucket.value)"
                }
            }
            return "Chave invalida: \(key)"
        }
        return "\(buckets)"
    }
}

var Dictionary = HashTable<String, String>(capacity: 10)
Dictionary.insert(key: "name", value: "cim borg")
Dictionary.insert(key: "animal", value: "dog")
Dictionary.insert(key: "mane", value: "juba")

print("----------------")
print(Dictionary.list(getValueIn: "name"))
print(Dictionary.list(getValueIn: "animal"))
print(Dictionary.list(getValueIn: "mane"))
print(Dictionary.list(getValueIn: "bleh"))
print("----------------")
print(Dictionary.list())
