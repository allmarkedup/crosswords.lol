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

    markComplete({ detail }) {
      if (!detail.initial) {
        this.celebrate();
      }
      this.finished = true;
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
      fireConfetti();

      this.vibing = true;
      vibeTimer = setTimeout(() => {
        this.vibing = false;
      }, 7000);
    },

    destroy() {
      clearTimeout(vibeTimer);
    },
  };
}
