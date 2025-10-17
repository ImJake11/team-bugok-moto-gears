double calculatePercentageChange(double today, double yesterday) {
  if (yesterday == 0) {
    return today > 0 ? 100 : 0;
  }
  return ((today - yesterday) / yesterday) * 100;
}
