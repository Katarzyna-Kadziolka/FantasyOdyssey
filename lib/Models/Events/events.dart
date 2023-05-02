import 'package:fantasy_odyssey/Models/Events/bag_end_to_grey_havens.dart';
import 'package:fantasy_odyssey/Models/Events/bag_end_to_rivendell.dart';
import 'package:fantasy_odyssey/Models/Events/isengard_to_rivendell.dart';
import 'package:fantasy_odyssey/Models/Events/lothrien_to_rauros.dart';
import 'package:fantasy_odyssey/Models/Events/minas_tirith_to_isengard.dart';
import 'package:fantasy_odyssey/Models/Events/rauros_to_mount_doom.dart';
import 'package:fantasy_odyssey/Models/Events/rivendell_to_bag_end.dart';
import 'package:fantasy_odyssey/Models/Events/rivendell_to_lothlorien.dart';
import 'package:fantasy_odyssey/Models/history_event.dart';

class Events {
  late List<HistoryEvent> events;

  Events() {
    var bagEndToRivedell = BagEndToRivendell();
    var rivendellToLothrien = RivendellToLothlorien();
    var lothrienToRauros = LothlorienToRauros();
    var raurosToMountDoom = RaurosToMountDoom();
    var minasTirithToIsengard = MinasTirithToIsengard();
    var isengardToRivendell = IsengardToRivendell();
    var rivendellToBagEnd = RivendellToBagEnd();
    var bagEndToGreyHavens = BagEndToGreyHavens();

    events = [
      ...bagEndToRivedell.events,
      ...rivendellToLothrien.events,
      ...lothrienToRauros.events,
      ...raurosToMountDoom.events,
      ...minasTirithToIsengard.events,
      ...isengardToRivendell.events,
      ...rivendellToBagEnd.events,
      ...bagEndToGreyHavens.events];
  }
}