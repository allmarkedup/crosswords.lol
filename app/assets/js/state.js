export default function state(Alpine) {
  return {
    crosswords: Alpine.$persist({}).as("crosswords-state"),

    getCrosswordState(id) {
      if (!this.crosswords[id]?.entries) {
        this.crosswords[id] = { activeCellId: null, timer: null, entries: {} };
      }
      return this.crosswords[id];
    },
  };
}
