import Foundation

class UserPersonalProfile {
    var level: Int
    var points: Double
    var coefficients: [Double]


    init(level: Int = 1, points: Double = 0.0, coefficients: [Double] = []) {
        self.level = level
        self.points = points
        self.coefficients = coefficients
    }


    func updateProgress(withPoints newPoints: Double, coefficient: Double) {
        points += newPoints
        coefficients.append(coefficient)
        evaluateLevelUpgrade()
    }


    private func evaluateLevelUpgrade() {
        let averageCoefficient = coefficients.isEmpty ? 0 : coefficients.reduce(0, +) / Double(coefficients.count)

        // Define your criteria for level upgrade
        if averageCoefficient > 1.0 {
            level += 1
            // Reset points and coefficients after level upgrade
            resetProgress()
        }
    }


    func setLevel(to newLevel: Int) {
        level = newLevel
        resetProgress()
    }


    private func resetProgress() {
        points = 0
        coefficients.removeAll()
    }
}
