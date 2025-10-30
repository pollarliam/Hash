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
    
     mutating func hasher(_ key: Key) -> Int {
        var hashValue = 0
        let stringKey = "\(key)"
        
        for scalar in stringKey.unicodeScalars {
            hashValue += Int(scalar.value)
        }
        
        return hashValue % buckets.count
    }
    
    mutating func insert(key: Key, value: Value) {
        let index = hasher(key)
        
        // Check if bucket already has something
        if let existingBucket = buckets[index] {
            // If key already exists, update its value
            if existingBucket.key == key {
                buckets[index]?.value = value
            } else {
                print("Colisão: \(index),  \(key)")
            }
        } else {
            // Empty slot, insert new bucket
            buckets[index] = bucket(key: key, value: value)
            return print("Adicionado \(key) em índice \(index)")
        }
    }
}

var table = HashTable<String, String>(capacity: 10)
table.insert(key: "name", value: "Pedro")

print(table.hasher("name"))
print(table)
