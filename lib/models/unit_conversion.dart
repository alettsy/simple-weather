/// Unit conversion options extended on double.
extension UnitConversion on double {
  double toCelcius() {
    return this - 273.15;
  }
}
