import HealthKit

class HealthStore: ObservableObject {
    private let healthStore = HKHealthStore()

    init() {
        requestAuthorization()
    }

    private func requestAuthorization() {
        let typesToShare: Set = [HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent)!]
        let typesToRead: Set = [HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent)!]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            if let error = error {
                print("Error requesting authorization: \(error.localizedDescription)")
            }
        }
    
    }
    
    func addBACData(bacValue: Double) {
        guard let bacType = HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent) else { return }

        let bacQuantity = HKQuantity(unit: HKUnit.percent(), doubleValue: bacValue)
        let bacSample = HKQuantitySample(type: bacType, quantity: bacQuantity, start: Date(), end: Date())

        healthStore.save(bacSample) { success, error in
            if let error = error {
                print("Error saving BAC data!: \(error.localizedDescription)")
            }
        }
    }
    
    func getLatestBAC(completion: @escaping (Double) -> Void) {
        guard let bacType = HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent) else { return }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: bacType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
            if let error = error {
                print("Error fetching BAC data: \(error.localizedDescription)")
                completion(0.0)
            } else if let sample = samples?.first as? HKQuantitySample {
                let bacValue = sample.quantity.doubleValue(for: HKUnit.percent())
                completion(bacValue)
            } else {
                completion(0.0)
            }
        }

        healthStore.execute(query)
    }
    
    
}
