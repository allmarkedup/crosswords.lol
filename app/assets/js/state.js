export default function state(Alpine) {
  return {
    settings: Alpine.$persist({
      timer: false,
    }).as("settings"),
    crosswords: Alpine.$persist({}).as("crosswords-state"),

    getCrosswordState(id) {
      if (!this.crosswords[id]?.entries) {
        this.crosswords[id] = { activeCellId: null, timer: null, entries: {} };
      }
      return this.crosswords[id];
    },
  };
}
