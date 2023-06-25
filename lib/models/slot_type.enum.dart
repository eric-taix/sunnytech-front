enum SlotType {
  openingKeynote,
  conf,
  workshop,
  quickie,
  pause,
  closingKeynote,
  unknown
}

SlotType parseSlotType(String type) {
  switch (type) {
    case 'OPENING_KEYNOTE':
      return SlotType.openingKeynote;
    case 'CLOSING_KEYNOTE':
      return SlotType.closingKeynote;
    case 'CONF':
      return SlotType.conf;
    case 'WORKSHOP':
      return SlotType.workshop;
    case 'QUICKIE':
      return SlotType.quickie;
    case 'PAUSE':
      return SlotType.pause;
    default:
      return SlotType.unknown;
  }
}
