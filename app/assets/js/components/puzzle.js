import { fireConfetti } from "../helpers/confetti";

export default function Puzzle({ id, entries }) {
  let vibeTimer = null;

  return {
    entries: entries,
    state: null,
    vibing: false,
    finished: false,
    $puzzle: null,

    init() {
      this.$puzzle = this;
      this.state = this.getState(id);
    },

    getState(id) {
      if (!this.$state.crosswords[id]?.values) {
        this.$state.crosswords[id] = {
          activeEntryId: this.entries[0].id,
          activeCellId: null,
          timer: null,
          values: {},
          events: [],
        };
      }
      return this.$state.crosswords[id];
    },

    record(name, detail = {}) {
      if (!Array.isArray(this.state.events)) {
        this.state.events = [];
      }
      this.state.events.push({ name, detail });
    },

    reset() {
      this.$puzzle.state.events = [];
      this.finished = false;
    },

    celebrate() {
      this.finished = true;
      fireConfetti();
      this.vibing = true;
      vibeTimer = setTimeout(() => {
        this.vibing = false;
      }, 5000);
    },

    destroy() {
      clearTimeout(vibeTimer);
    },
  };
}
