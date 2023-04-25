enum Phase {
  bagEndToRivendell("Bag End to Rivendell"),
  rivendellToLothlorien("Rivendell to Lothlorien"),
  lothlorienToRauros("Lothlorien to Rauros"),
  raurosToMountDoom("Rauros to Mount Doom"),
  minasTirithToIsengard("Minas Tirith to Isengard"),
  isengardToRivendell("Isengard to Rivendell"),
  rivendellToBagEnd("Rivendell to Bag End"),
  bagEndToGreyHavens("Bag End to Grey Havens");

  const Phase(this.text);
  final String text;
}